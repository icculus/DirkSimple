/**
 * DirkSimple; a dirt-simple player for FMV games.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#include <stdio.h>
#include <stdarg.h>
#include <setjmp.h>

#include "libretro.h"
#include "dirksimple_platform.h"

static void fallback_log(enum retro_log_level level, const char *fmt, ...)
{
    (void)level;
    va_list va;
    va_start(va, fmt);
    vfprintf(stderr, fmt, va);
    va_end(va);
}

typedef struct DirkSimpleAudioQueue
{
    struct DirkSimpleAudioQueue *next;
    int num_samples;
    int16_t samples[];
} DirkSimpleAudioQueue;

static bool panic_triggered = false;
static jmp_buf panic_jmpbuf;
static retro_usec_t prev_runtime_usecs = 0;
static retro_usec_t runtime_usecs = 0;
static uint64_t keyboard_inputbits = 0;
static retro_log_printf_t log_cb = fallback_log;
static retro_environment_t environ_cb;
static DirkSimple_PixFmt pixfmt = DIRKSIMPLE_PIXFMT_BGRA;
static void *framebuffer = NULL;
static uint32_t framebuffer_width = 0;
static uint32_t framebuffer_height = 0;
static double framebuffer_fps = 0.0;
static int audio_channels = 0;
static int audio_freq = 0;
static DirkSimpleAudioQueue audio_queue_head;
static DirkSimpleAudioQueue *audio_queue_tail = &audio_queue_head;

static void post_notification(const char *msgstr, const unsigned int duration)
{
    unsigned int msgver = 0;

    if (!environ_cb) {
        return;
    }

    if (!environ_cb(RETRO_ENVIRONMENT_GET_MESSAGE_INTERFACE_VERSION, &msgver)) {
        msgver = 0;
    }

    if (msgver == 0) {
        struct retro_message msg = { msgstr, duration };
        environ_cb(RETRO_ENVIRONMENT_SET_MESSAGE, &msg);
    } else {
        struct retro_message_ext msg;
        msg.msg = msgstr;
        msg.duration = duration;
        msg.priority = 99;
        msg.level = RETRO_LOG_INFO;
        msg.target = RETRO_MESSAGE_TARGET_OSD;
        msg.type = RETRO_MESSAGE_TYPE_NOTIFICATION_ALT;
        msg.progress = -1;
        environ_cb(RETRO_ENVIRONMENT_SET_MESSAGE_EXT, &msg);
    }
}

void DirkSimple_panic(const char *str)
{
    panic_triggered = true;
    log_cb(RETRO_LOG_ERROR, "DirkSimple PANIC: %s\n", str);
    post_notification("DirkSimple PANIC", 10000);  // !!! FIXME: I'd like to just leave this text on the screen permanently, but I don't want to add a font and draw it, so use the frontend's notification facilities.
    post_notification(str, 10000);  // !!! FIXME: I'd like to just leave this text on the screen permanently, but I don't want to add a font and draw it, so use the frontend's notification facilities.

    if (framebuffer) {  // blank the framebuffer to red to signify things are busted.
        const int total = framebuffer_width * framebuffer_height;
        if (pixfmt == DIRKSIMPLE_PIXFMT_RGB565) {
            const uint16_t color = 0xF800;
            uint16_t *dst = (uint16_t *) framebuffer;
            for (int i = 0; i < total; i++) {
                dst[i] = color;
            }
        } else {
            const uint32_t color = 0xFFFF0000;
            uint32_t *dst = (uint32_t *) framebuffer;
            for (int i = 0; i < total; i++) {
                dst[i] = color;
            }
        }
    }

    longjmp(panic_jmpbuf, 1);  // this function can't return, so we mark a setbuf when starting a tick.
}

void DirkSimple_writelog(const char *str)
{
    log_cb(RETRO_LOG_INFO, "%s\n", str);
}


static long DirkSimple_stdio_read(DirkSimple_Io *io, void *buf, long buflen)
{
    const size_t rc = fread(buf, 1, buflen, (FILE *) io->userdata);
    if (rc == 0) {
        return ferror((FILE *) io->userdata) ? -1 : 0;
    }
    return (long) rc;
}

static long DirkSimple_stdio_streamlen(DirkSimple_Io *io)
{
    FILE *f = (FILE *) io->userdata;
    const long origpos = ftell(f);
    long retval = -1;
    if (fseek(f, 0, SEEK_END) == 0) {
        retval = ftell(f);
        fseek(f, origpos, SEEK_SET);
    }
    return retval;
}

static int DirkSimple_stdio_seek(DirkSimple_Io *io, long absolute_offset)
{
    return fseek((FILE *) io->userdata, absolute_offset, SEEK_SET) != -1;
}

static void DirkSimple_stdio_close(DirkSimple_Io *io)
{
    fclose((FILE *) io->userdata);
    free(io);
}

DirkSimple_Io *DirkSimple_openfile_read(const char *path)
{
    DirkSimple_Io *io = NULL;
    FILE *f = fopen(path, "rb");
    if (f) {
        io = DirkSimple_xmalloc(sizeof (DirkSimple_Io));
        io->read = DirkSimple_stdio_read;
        io->streamlen = DirkSimple_stdio_streamlen;
        io->seek = DirkSimple_stdio_seek;
        io->close = DirkSimple_stdio_close;
        io->userdata = f;
    }
    return io;
}


#if 0 // this is marked as experimental (and does not appear to be available in the Steam version of RetroArch, as of January 2023, but maybe I'm doing something wrong).
static struct retro_vfs_interface *retro_vfs = NULL;

static long DirkSimple_retro_vfs_read(DirkSimple_Io *io, void *buf, long buflen)
{
    struct retro_vfs_file_handle *vio = (struct retro_vfs_file_handle *) io->userdata;
    return (long) retro_vfs->read(vio, buf, (uint64_t) buflen);
}

static long DirkSimple_retro_vfs_streamlen(DirkSimple_Io *io)
{
    struct retro_vfs_file_handle *vio = (struct retro_vfs_file_handle *) io->userdata;
    return (long) retro_vfs->size(vio);
}

static int DirkSimple_retro_vfs_seek(DirkSimple_Io *io, long absolute_offset)
{
    struct retro_vfs_file_handle *vio = (struct retro_vfs_file_handle *) io->userdata;
    return retro_vfs->seek(vio, (int64_t) absolute_offset, RETRO_VFS_SEEK_POSITION_START) != -1;
}

static void DirkSimple_retro_vfs_close(DirkSimple_Io *io)
{
    struct retro_vfs_file_handle *vio = (struct retro_vfs_file_handle *) io->userdata;
    retro_vfs->close(vio);
    free(io);
}

DirkSimple_Io *DirkSimple_openfile_read(const char *path)
{
    DirkSimple_Io *io = NULL;
    struct retro_vfs_file_handle *vio = retro_vfs->open(path, RETRO_VFS_FILE_ACCESS_READ, 0);
    if (vio) {
        io = DirkSimple_xmalloc(sizeof (DirkSimple_Io));
        io->read = DirkSimple_retro_vfs_read;
        io->streamlen = DirkSimple_retro_vfs_streamlen;
        io->seek = DirkSimple_retro_vfs_seek;
        io->close = DirkSimple_retro_vfs_close;
        io->userdata = vio;
    }
    return io;
}
#endif

void DirkSimple_audioformat(int channels, int freq)
{
    audio_channels = channels;
    audio_freq = freq;
}

void DirkSimple_videoformat(const char *gametitle, uint32_t width, uint32_t height, double fps)
{
    framebuffer = DirkSimple_xcalloc(width * height, (pixfmt == DIRKSIMPLE_PIXFMT_RGB565) ? sizeof (uint16_t) : sizeof (uint32_t));
    framebuffer_width = width;
    framebuffer_height = height;
    framebuffer_fps = fps;
}

void DirkSimple_discvideo(const uint8_t *pixels)
{
    // !!! FIXME: this would be much more efficient if we can just hand yuv data to the renderer, but we'll need to use a shader for that.
    memcpy(framebuffer, pixels, framebuffer_width * framebuffer_height * ((pixfmt == DIRKSIMPLE_PIXFMT_RGB565) ? sizeof (uint16_t) : sizeof (uint32_t)));
}

void DirkSimple_discaudio(const float *pcm, int numframes)
{
    int i;
    const int total = numframes * 2;
    DirkSimpleAudioQueue *item = (DirkSimpleAudioQueue *) DirkSimple_xmalloc(sizeof (DirkSimpleAudioQueue) + (total * sizeof (int16_t)));
    int16_t *dst = item->samples;

    item->num_samples = total;
    item->next = NULL;

    if (audio_channels == 1) {  // convert from mono to stereo.
        for (i = 0; i < numframes; i++) {
            dst[0] = dst[1] = (int16_t) (pcm[i] * 32767.0f);
            dst += 2;
        }
    } else if (audio_channels == 2) {
        for (i = 0; i < total; i++) {
            dst[i] = (int16_t) (pcm[i] * 32767.0f);
        }
    } else {
        free(item);
        return;  // oh well.
    }

    audio_queue_tail->next = item;
    audio_queue_tail = item;
}

void DirkSimple_cleardiscaudio(void)
{
    DirkSimpleAudioQueue *i;
    DirkSimpleAudioQueue *next;

    for (i = audio_queue_head.next; i != NULL; i = next) {
        next = i->next;
        free(i);
    }
    
    audio_queue_head.next = NULL;
    audio_queue_tail = &audio_queue_head;
}

void retro_init(void) {}
void retro_deinit(void) {}

unsigned retro_api_version(void) { return RETRO_API_VERSION; }

void retro_set_controller_port_device(unsigned port, unsigned device)
{
    //log_cb(RETRO_LOG_INFO, "Plugging device %u into port %u.\n", device, port);
}

void retro_get_system_info(struct retro_system_info *info)
{
    memset(info, 0, sizeof (*info));
    info->library_name     = "dirksimple";
    info->library_version  = "0.1";
    info->need_fullpath    = true;  // don't make libretro cache a multi-gigabyte movie file in RAM.  :)
    info->valid_extensions = "ogv|dirksimple";  // we'll just let .dirksimple exist as an extension for convenience, but it's just the same Ogg Theora file.
 }

static retro_video_refresh_t video_cb;
static retro_audio_sample_t audio_cb;
static retro_audio_sample_batch_t audio_batch_cb;
static retro_input_poll_t input_poll_cb;
static retro_input_state_t input_state_cb;

void retro_get_system_av_info(struct retro_system_av_info *info)
{
    info->geometry.base_width   = framebuffer_width;
    info->geometry.base_height  = framebuffer_height;
    info->geometry.max_width    = framebuffer_width;
    info->geometry.max_height   = framebuffer_height;
    info->geometry.aspect_ratio = ((float) framebuffer_width) / ((float) framebuffer_height);;

    info->timing.fps = framebuffer_fps;
    info->timing.sample_rate = (double) audio_freq;
}


static void RETRO_CALLCONV frame_time_callback(retro_usec_t usec);
static void RETRO_CALLCONV keyboard_callback(bool down, unsigned keycode, uint32_t character, uint16_t key_modifiers);

void retro_set_environment(retro_environment_t cb)
{
    struct retro_log_callback logging;

    environ_cb = cb;

    if (setjmp(panic_jmpbuf) != 0) {
        return;  // we called panic during this function, just bail.
    }

    if (cb(RETRO_ENVIRONMENT_GET_LOG_INTERFACE, &logging)) {
        log_cb = logging.log;
    } else {
        log_cb = fallback_log;
    }

#if 0 // this is marked as experimental (and does not appear to be available in the Steam version of RetroArch, as of January 2023, but maybe I'm doing something wrong).
    struct retro_vfs_interface_info vfs_info;
    vfs_info.required_interface_version = 1;
    if (cb(RETRO_ENVIRONMENT_GET_VFS_INTERFACE, &vfs_info)) {
        retro_vfs = vfs_info.iface;
    } else {
        // !!! FIXME: this can have a stdio fallback or whatever, but until we find out this is a widespread problem in the field, I'm just calling panic here.
        DirkSimple_panic("Libretro frontend doesn't have VFS interface, aborting! Please upgrade.");
    }
#endif

    static const struct retro_controller_description controller = { "Generic game controller", RETRO_DEVICE_SUBCLASS(RETRO_DEVICE_JOYPAD, 0) };
    static const struct retro_controller_info ports[] = {
        { &controller, 1 },
        { NULL, 0 },
    };

    cb(RETRO_ENVIRONMENT_SET_CONTROLLER_INFO, (void *) ports);

    struct retro_frame_time_callback ftcb;
    ftcb.callback = frame_time_callback;
    ftcb.reference = 1000000 / 30;   // Laserdiscs ran at 30fps, Dragon's Lair is _actually_ 23.976fps, but the disc would duplicate frames to move it up to 30. We'll aim for 30 for now.
    cb(RETRO_ENVIRONMENT_SET_FRAME_TIME_CALLBACK, (void *) &ftcb);

    struct retro_keyboard_callback kbcb;
    kbcb.callback = keyboard_callback;
    cb(RETRO_ENVIRONMENT_SET_KEYBOARD_CALLBACK, (void *) &kbcb);
}

void retro_set_audio_sample(retro_audio_sample_t cb) { audio_cb = cb; }
void retro_set_audio_sample_batch(retro_audio_sample_batch_t cb) { audio_batch_cb = cb; }
void retro_set_input_poll(retro_input_poll_t cb) { input_poll_cb = cb; }
void retro_set_input_state(retro_input_state_t cb) { input_state_cb = cb; }
void retro_set_video_refresh(retro_video_refresh_t cb) { video_cb = cb; }

static void RETRO_CALLCONV frame_time_callback(retro_usec_t usec)
{
    prev_runtime_usecs = runtime_usecs;
    runtime_usecs += usec;
}

static void RETRO_CALLCONV keyboard_callback(bool down, unsigned keycode, uint32_t ch, uint16_t key_modifiers)
{
    switch (keycode) {
        #define CHECK_KEYBOARD_INPUT(retroid, dirksimpleid) case RETROK_##retroid: if (down) { keyboard_inputbits |= DIRKSIMPLE_INPUT_##dirksimpleid; } else { keyboard_inputbits &= ~DIRKSIMPLE_INPUT_##dirksimpleid; }; break;
        CHECK_KEYBOARD_INPUT(UP, UP);
        CHECK_KEYBOARD_INPUT(DOWN, DOWN);
        CHECK_KEYBOARD_INPUT(LEFT, LEFT);
        CHECK_KEYBOARD_INPUT(RIGHT, RIGHT);
        CHECK_KEYBOARD_INPUT(TAB, COINSLOT);
        CHECK_KEYBOARD_INPUT(z, ACTION1);
        CHECK_KEYBOARD_INPUT(x, ACTION2);   // !!! FIXME: for now.
        CHECK_KEYBOARD_INPUT(RETURN, START);
        CHECK_KEYBOARD_INPUT(KP_ENTER, START);
        #undef CHECK_KEYBOAD_INPUT
        default: break;
    }
}

static uint64_t get_current_inputbits(void)
{
    uint64_t joypad_inputbits = 0;

    input_poll_cb();

    #define CHECK_JOYPAD_INPUT(retroid, dirksimpleid) if (input_state_cb(0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_##retroid) != 0) { joypad_inputbits |= DIRKSIMPLE_INPUT_##dirksimpleid; }
    CHECK_JOYPAD_INPUT(UP, UP);
    CHECK_JOYPAD_INPUT(DOWN, DOWN);
    CHECK_JOYPAD_INPUT(LEFT, LEFT);
    CHECK_JOYPAD_INPUT(RIGHT, RIGHT);
    CHECK_JOYPAD_INPUT(A, ACTION1);  // !!! FIXME: what's best here?
    CHECK_JOYPAD_INPUT(X, ACTION2);  // !!! FIXME: what's best here?
    CHECK_JOYPAD_INPUT(SELECT, COINSLOT);
    CHECK_JOYPAD_INPUT(START, START);
    #undef CHECK_JOYPAD_INPUT

    return joypad_inputbits | keyboard_inputbits;
}

void retro_run(void)
{
    setjmp(panic_jmpbuf);  // this will set panic_triggered before the longjmp.

    if (!panic_triggered) {  // don't run if we're exploded before.
        bool updated = false;
        if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE_UPDATE, &updated) && updated) {
            // !!! FIXME: ?
            //check_variables();
        }

        DirkSimple_tick(runtime_usecs / 1000, get_current_inputbits());

        // Feed some more audio to the frontend for playback.
        // !!! FIXME: This is kinda hacky, but it works well enough for now.
        int sent_sample_frames = 0;
        DirkSimpleAudioQueue *i;
        DirkSimpleAudioQueue *next;
        for (i = audio_queue_head.next; i != NULL; i = next) {
            const int num_frames = i->num_samples / 2;
            next = i->next;
            const size_t rc = audio_batch_cb(i->samples, num_frames);
            if (rc == 0) { // maybe the buffer is full?
                break;
            } else if (rc < (size_t) num_frames) {
                memmove(&i->samples[0], &i->samples[rc*2], (i->num_samples - (rc*2)) * sizeof (int16_t));
                i->num_samples -= rc*2;
                break;
            }
            audio_queue_head.next = next;
            if (audio_queue_tail == i) {
                audio_queue_tail = &audio_queue_head;
            }
            free(i);
            sent_sample_frames += num_frames;
            if (sent_sample_frames >= 1024) {
                break;
            }
        }
    }
    video_cb(framebuffer, framebuffer_width, framebuffer_height, framebuffer_width * ((pixfmt == DIRKSIMPLE_PIXFMT_RGB565) ? sizeof (uint16_t) : sizeof (uint32_t)));
}

static bool set_pixfmt(enum retro_pixel_format fmt)
{
    return environ_cb(RETRO_ENVIRONMENT_SET_PIXEL_FORMAT, &fmt) ? true : false;
}

bool retro_load_game(const struct retro_game_info *info)
{
    panic_triggered = false;

    // !!! FIXME: try to use OpenGL so we can push YUV data through a shader?

    if (set_pixfmt(RETRO_PIXEL_FORMAT_XRGB8888)) {
        pixfmt = DIRKSIMPLE_PIXFMT_BGRA;
    } else if (set_pixfmt(RETRO_PIXEL_FORMAT_RGB565)) {
        pixfmt = DIRKSIMPLE_PIXFMT_RGB565;
    } else {
        log_cb(RETRO_LOG_INFO, "Couldn't set a pixel format, giving up.\n");
        return false;
    }

    const char *sysdir = NULL;
    if (!environ_cb(RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY, &sysdir) || !sysdir) {
        log_cb(RETRO_LOG_INFO, "Couldn't find system directory, giving up.\n");
        return false;
    }

    bool retval = false;
    char *basedir = NULL;

    if (setjmp(panic_jmpbuf) == 0) {  // if non-zero, something called DirkSimple_panic()
        const size_t slen = strlen(sysdir) + strlen("DirkSimple") + 2;
        basedir = DirkSimple_xmalloc(slen);
        snprintf(basedir, slen, "%s/DirkSimple", sysdir);

        // DirkSimple_startup cleans up previous runs automatically.
        DirkSimple_startup(basedir, info->path, NULL, pixfmt);

        while (!framebuffer_width || !audio_channels) {
            DirkSimple_tick(0, 0);  // spin here until we either panic or have the av dimensions.
        }

        retval = true;
    }

    free(basedir);

    return retval;
}

void retro_unload_game(void)
{
    DirkSimple_shutdown();
    free(framebuffer);
    framebuffer = NULL;
    framebuffer_width = 0;
    framebuffer_height = 0;
    framebuffer_fps = 0.0;
    DirkSimple_cleardiscaudio();
    audio_channels = 0;
    audio_freq = 0;
}

void retro_reset(void)
{
    DirkSimple_restart();
}

unsigned retro_get_region(void)
{
   return RETRO_REGION_NTSC;
}

bool retro_load_game_special(unsigned type, const struct retro_game_info *info, size_t num)
{
   return false;
}

size_t retro_serialize_size(void)
{
    const size_t retval = DirkSimple_serialize(NULL, 0);
    log_cb(RETRO_LOG_INFO, "Serialize size == %u bytes\n", (unsigned int) retval);
    return retval;
}

bool retro_serialize(void *data_, size_t size)
{
    const size_t rc = DirkSimple_serialize(data_, size);
    return ((rc > 0) && (rc <= size)) ? true : false;
}

bool retro_unserialize(const void *data_, size_t size)
{
    return (DirkSimple_unserialize(data_, size) != 0) ? true : false;
}

void *retro_get_memory_data(unsigned id)
{
   (void)id;
   return NULL;
}

size_t retro_get_memory_size(unsigned id)
{
   (void)id;
   return 0;
}

void retro_cheat_reset(void)
{}

void retro_cheat_set(unsigned index, bool enabled, const char *code)
{
   (void)index;
   (void)enabled;
   (void)code;
}

// end of dirksimple_libretro.c ...

