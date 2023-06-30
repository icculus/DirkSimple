/**
 * DirkSimple; a dirt-simple player for FMV games.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#ifdef _MSC_VER
#define WIN32_API_LEAN_AND_MEAN 1
#include <windows.h>
#else
#include <dirent.h>
#endif

#include "SDL.h"

#include "dirksimple_platform.h"

typedef struct SaveSlot
{
    size_t len;
    uint8_t *data;
} SaveSlot;

typedef struct PlayingWave
{
    DirkSimple_Wave *wave;
    int framepos;
    struct PlayingWave *next;
} PlayingWave;

static SDL_Window *GWindow = NULL;
static SDL_Renderer *GRenderer = NULL;
static SDL_Texture *GLaserDiscTexture = NULL;
static SDL_AudioDeviceID GAudioDeviceID = 0;
static int GAudioChannels = 0;
static int GLaserDiscTextureWidth = 0;
static int GLaserDiscTextureHeight = 0;
static SDL_GameController *GGameController = NULL;
static uint8_t GSaveSlot = 0;
static SaveSlot GSaveData[8];
static uint64_t GKeyInputBits = 0;
static SDL_bool GWantFullscreen = SDL_FALSE;
static PlayingWave *GPlayingWaves = NULL;
static SDL_AudioStream *GDiscAudioStream = NULL;

void *DirkSimple_malloc(size_t len) { return SDL_malloc(len); }
void *DirkSimple_calloc(size_t nmemb, size_t len) { return SDL_calloc(nmemb, len); }
void *DirkSimple_realloc(void *ptr, size_t len) { return SDL_realloc(ptr, len); }
char *DirkSimple_strdup(const char *str) { return SDL_strdup(str); }
void DirkSimple_free(void *ptr) { return SDL_free(ptr); }

void DirkSimple_panic(const char *str)
{
    SDL_Log("DirkSimple PANIC: %s", str);
    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "DirkSimple PANIC", str, GWindow);
    SDL_Quit();
    #ifdef __EMSCRIPTEN__
    emscripten_cancel_main_loop();  // this should "kill" the app.
    #endif
    exit(1);
}

static DIRKSIMPLE_NORETURN void sdlpanic(const char *what)
{
    const char *sdlerr = SDL_GetError();
    const size_t slen = SDL_strlen(sdlerr) + SDL_strlen(what) + 32;
    char *errstr = SDL_malloc(slen);
    if (errstr) {
        SDL_snprintf(errstr, slen, "%s: %s", what, SDL_GetError());
    }
    DirkSimple_panic(errstr ? errstr : what);
}

void DirkSimple_writelog(const char *str)
{
    SDL_Log("%s", str);
}

static long DirkSimple_rwops_read(DirkSimple_Io *io, void *buf, long buflen)
{
    return (long) SDL_RWread((SDL_RWops *) io->userdata, buf, 1, buflen);
}

static long DirkSimple_rwops_streamlen(DirkSimple_Io *io)
{
    SDL_RWops *rwops = (SDL_RWops *) io->userdata;
    const Sint64 origpos = SDL_RWtell(rwops);
    const long retval = (long) SDL_RWseek(rwops, 0, RW_SEEK_END);
    SDL_RWseek(rwops, origpos, RW_SEEK_SET);
    return retval;
}

static int DirkSimple_rwops_seek(DirkSimple_Io *io, long absolute_offset)
{
    return SDL_RWseek((SDL_RWops *) io->userdata, absolute_offset, RW_SEEK_SET) != -1;
}

static void DirkSimple_rwops_close(DirkSimple_Io *io)
{
    SDL_RWclose((SDL_RWops *) io->userdata);
    free(io);
}

DirkSimple_Io *DirkSimple_openfile_read(const char *path)
{
    DirkSimple_Io *io = NULL;
    SDL_RWops *rwops = SDL_RWFromFile(path, "rb");
    if (rwops) {
        io = DirkSimple_xmalloc(sizeof (DirkSimple_Io));
        io->read = DirkSimple_rwops_read;
        io->streamlen = DirkSimple_rwops_streamlen;
        io->seek = DirkSimple_rwops_seek;
        io->close = DirkSimple_rwops_close;
        io->userdata = rwops;
    }
    return io;
}

static void SDLCALL audio_callback(void *userdata, Uint8 *stream, int len)
{
    PlayingWave *pw = GPlayingWaves;
    PlayingWave *prev = NULL;
    const int chans = GAudioChannels;
    const int got = SDL_AudioStreamGet(GDiscAudioStream, stream, len);  // just fill in as much disc audio as possible.

    if (got < len) {
        SDL_memset(stream + got, '\0', len - got);
    }

    while (pw) {
        PlayingWave *next = pw->next;
        if (pw->framepos <= pw->wave->numframes) {
            const int avail = (int) ((pw->wave->numframes - pw->framepos) * chans * sizeof (float));
            const Uint32 cpy = SDL_min(len, avail);
            SDL_MixAudioFormat(stream, (const Uint8 *) (pw->wave->pcm + (pw->framepos * chans)), AUDIO_F32SYS, cpy, SDL_MIX_MAXVOLUME);
            pw->framepos += (cpy / chans) / sizeof (float);
        }

        // done with this sound? Take it out of the playing list.
        if (pw->framepos >= pw->wave->numframes) {
            if (prev) {
                prev->next = next;
            } else {
                GPlayingWaves = next;
            }
            DirkSimple_free(pw);
        }
        prev = pw;
        pw = next;
    }
}

void DirkSimple_audioformat(int channels, int freq)
{
    SDL_AudioSpec spec;
    SDL_zero(spec);
    spec.freq = freq;
    spec.format = AUDIO_F32SYS;
    spec.channels = channels;
    spec.samples = 1024;
    spec.callback = audio_callback;

    // this does no conversion, we're just using it as a data queue.
    GDiscAudioStream = SDL_NewAudioStream(spec.format, spec.channels, spec.freq, spec.format, spec.channels, spec.freq);
    if (!GDiscAudioStream) {
        DirkSimple_log("Failed to create disc audio stream: %s", SDL_GetError());
        DirkSimple_log("Going on without sound!");
        return;
    }

    GAudioChannels = channels;
    GAudioDeviceID = SDL_OpenAudioDevice(NULL, 0, &spec, NULL, 0);
    if (GAudioDeviceID == 0) {
        DirkSimple_log("Audio device open failed: %s", SDL_GetError());
        DirkSimple_log("Going on without sound!");
        SDL_FreeAudioStream(GDiscAudioStream);
        GDiscAudioStream = NULL;
        return;
    }

    SDL_PauseAudioDevice(GAudioDeviceID, 0);
}

static SDL_bool load_icon_from_dir(SDL_Window *window, const char *dir)
{
    SDL_bool retval = SDL_FALSE;
    if (dir) {  // oh well if not.
        const size_t slen = SDL_strlen(dir) + 32;
        char *iconpath = (char *) SDL_malloc(slen);
        if (iconpath) {
            SDL_Surface *icon;
            SDL_snprintf(iconpath, slen, "%sicon.bmp", dir);
            icon = SDL_LoadBMP(iconpath);
            if (icon) {
                SDL_SetWindowIcon(window, icon);
                SDL_FreeSurface(icon);
                retval = SDL_TRUE;
            }
            SDL_free(iconpath);
        }
    }
    return retval;
}

static void load_icon(SDL_Window *window)
{
    if (!load_icon_from_dir(window, DirkSimple_gamedir())) {
        load_icon_from_dir(window, DirkSimple_datadir());
    }
}

void DirkSimple_videoformat(const char *gametitle, uint32_t width, uint32_t height, double fps)
{
    SDL_RendererInfo info;

    Uint32 flags = SDL_WINDOW_HIDDEN | SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI;
    if (GWantFullscreen) {
        flags = SDL_WINDOW_FULLSCREEN_DESKTOP;
    }

    GWindow = SDL_CreateWindow(gametitle ? gametitle : "DirkSimple", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, flags);
    if (!GWindow) {
        sdlpanic("Failed to create window");
    }

    load_icon(GWindow);

    GRenderer = SDL_CreateRenderer(GWindow, -1, SDL_RENDERER_PRESENTVSYNC);
    if (!GRenderer) {
        GRenderer = SDL_CreateRenderer(GWindow, -1, 0);
        if (!GRenderer) {
            sdlpanic("Failed to create renderer");
        }
    }

    SDL_SetRenderDrawColor(GRenderer, 0, 0, 0, 255);
    SDL_RenderSetLogicalSize(GRenderer, width, height);
    SDL_RenderClear(GRenderer);
    SDL_RenderPresent(GRenderer);
    SDL_ShowWindow(GWindow);
    SDL_RenderClear(GRenderer);
    SDL_RenderPresent(GRenderer);

    SDL_GetRendererInfo(GRenderer, &info);
    DirkSimple_log("SDL renderer backend: %s", info.name);

    GLaserDiscTexture = SDL_CreateTexture(GRenderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING, (int) width, (int) height);
    if (!GLaserDiscTexture) {
        sdlpanic("Failed to create laserdisc texture");
    }

    GLaserDiscTextureWidth = width;
    GLaserDiscTextureHeight = height;
}

void DirkSimple_discvideo(const uint8_t *iyuv)
{
    SDL_UpdateTexture(GLaserDiscTexture, NULL, iyuv, GLaserDiscTextureWidth);
}

void DirkSimple_discaudio(const float *pcm, int numframes)
{
    SDL_LockAudioDevice(GAudioDeviceID);
    SDL_AudioStreamPut(GDiscAudioStream, pcm, numframes * sizeof (float) * GAudioChannels);
    SDL_UnlockAudioDevice(GAudioDeviceID);
}

void DirkSimple_cleardiscaudio(void)
{
    SDL_LockAudioDevice(GAudioDeviceID);
    SDL_AudioStreamClear(GDiscAudioStream);
    SDL_UnlockAudioDevice(GAudioDeviceID);
}

void mainloop_shutdown(void)
{
    SDL_DestroyTexture(GLaserDiscTexture);
    SDL_DestroyRenderer(GRenderer);
    SDL_DestroyWindow(GWindow);

    SDL_CloseAudioDevice(GAudioDeviceID);

    SDL_FreeAudioStream(GDiscAudioStream);
    GDiscAudioStream = NULL;

    while (GPlayingWaves != NULL) {
        PlayingWave *next = GPlayingWaves->next;
        DirkSimple_free(GPlayingWaves);
        GPlayingWaves = next;
    }

    if (GGameController) {
        SDL_GameControllerClose(GGameController);
        GGameController = NULL;
    }

    DirkSimple_shutdown();

    SDL_Quit();
}

void DirkSimple_beginframe(void)
{
    if (GRenderer) {
        SDL_SetRenderDrawColor(GRenderer, 0, 0, 0, 255);
        SDL_RenderClear(GRenderer);
        SDL_RenderCopy(GRenderer, GLaserDiscTexture, NULL, NULL);
    }
}

void DirkSimple_clearscreen(uint8_t r, uint8_t g, uint8_t b)
{
    if (GRenderer) {
        SDL_SetRenderDrawColor(GRenderer, r, g, b, 255);
        SDL_RenderClear(GRenderer);
    }
}

void DirkSimple_drawsprite(DirkSimple_Sprite *sprite, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, uint8_t rmod, uint8_t gmod, uint8_t bmod)
{
    SDL_Texture *texture = (SDL_Texture *) sprite->platform_handle;
    const SDL_Rect srcrect = { sx, sy, sw, sh };
    const SDL_Rect dstrect = { dx, dy, dw, dh };

    if (!GRenderer) {
        return;
    }

    if (texture == NULL) {
        texture = SDL_CreateTexture(GRenderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STATIC, sprite->width, sprite->height);
        if (!texture) {
            char what[128];
            SDL_snprintf(what, sizeof (what), "Failed to create texture for sprite '%s'", sprite->name);
            sdlpanic(what);
        }
        sprite->platform_handle = texture;
        SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
        #if SDL_VERSION_ATLEAST(2, 0, 12)  /* GitHub Actions has an ancient SDL, apparently... */
        SDL_SetTextureScaleMode(texture, SDL_ScaleModeNearest);
        #endif
        SDL_UpdateTexture(texture, NULL, sprite->rgba, sprite->width * 4);
    }

    SDL_SetTextureColorMod(texture, rmod, gmod, bmod);
    SDL_RenderCopy(GRenderer, texture, &srcrect, &dstrect);
}

void DirkSimple_destroysprite(DirkSimple_Sprite *sprite)
{
    SDL_Texture *texture = (SDL_Texture *) sprite->platform_handle;
    if (texture) {
        SDL_DestroyTexture(texture);
    }
}

void DirkSimple_endframe(void)
{
    if (GRenderer) {
        SDL_RenderPresent(GRenderer);
    }
}

void DirkSimple_playwave(DirkSimple_Wave *wave)
{
    PlayingWave *pw = DirkSimple_xmalloc(sizeof (PlayingWave));
    SDL_LockAudioDevice(GAudioDeviceID);
    pw->wave = wave;
    pw->framepos = 0;
    pw->next = GPlayingWaves;
    GPlayingWaves = pw;
    SDL_UnlockAudioDevice(GAudioDeviceID);
}

void DirkSimple_destroywave(DirkSimple_Wave *wave)
{
    // does nothing at the moment.
}


static SDL_bool mainloop_iteration(void)
{
    uint64_t controllerinputbits = 0;
    SDL_Event e;

    while (SDL_PollEvent(&e)) {
        switch (e.type) {
            case SDL_KEYDOWN:
                switch (e.key.keysym.sym) {
                    case SDLK_UP: GKeyInputBits |= DIRKSIMPLE_INPUT_UP; break;
                    case SDLK_DOWN: GKeyInputBits |= DIRKSIMPLE_INPUT_DOWN; break;
                    case SDLK_LEFT: GKeyInputBits |= DIRKSIMPLE_INPUT_LEFT; break;
                    case SDLK_RIGHT: GKeyInputBits |= DIRKSIMPLE_INPUT_RIGHT; break;
                    case SDLK_SPACE: GKeyInputBits |= DIRKSIMPLE_INPUT_ACTION1; break;
                    case SDLK_LCTRL: GKeyInputBits |= DIRKSIMPLE_INPUT_ACTION2; break;  // for now I guess
                    case SDLK_TAB: GKeyInputBits |= DIRKSIMPLE_INPUT_COINSLOT; break;
                    case SDLK_RETURN: GKeyInputBits |= DIRKSIMPLE_INPUT_START; break;

                    case SDLK_ESCAPE:
                        return SDL_FALSE;  // !!! FIXME: remove this later?

                    case SDLK_LEFTBRACKET:
                    case SDLK_RIGHTBRACKET:
                        if (e.key.keysym.sym == SDLK_LEFTBRACKET) {
                            if (GSaveSlot == 0) {
                                GSaveSlot = 7;
                            } else {
                                GSaveSlot--;
                            }
                        } else {
                            if (GSaveSlot == 7) {
                                GSaveSlot = 0;
                            } else {
                                GSaveSlot++;
                            }
                        }
                        DirkSimple_log("Now using save slot #%d", (int) GSaveSlot);
                        break;

                    case SDLK_F2: {
                        const size_t len = DirkSimple_serialize(NULL, 0);
                        if (len == 0) {
                            DirkSimple_log("Failed to determine save state size! Nothing has been saved!");
                        } else {
                            void *data = DirkSimple_xmalloc(len);
                            if (DirkSimple_serialize(data, len) != len) {
                                DirkSimple_log("Failed to save state! Nothing has been saved!");
                                DirkSimple_free(data);
                            } else {
                                DirkSimple_log("State saved (%d bytes) to save slot #%d", (int) len, (int) GSaveSlot);
                                DirkSimple_free(GSaveData[GSaveSlot].data);
                                GSaveData[GSaveSlot].data = data;
                                GSaveData[GSaveSlot].len = len;
                            }
                        }
                        break;
                    }

                    case SDLK_F3: {
                        if ((GSaveData[GSaveSlot].data == NULL) || (GSaveData[GSaveSlot].len == 0)) {
                            DirkSimple_log("No save data currently in slot #%d, not restoring!", (int) GSaveSlot);
                        } else {
                            if (DirkSimple_unserialize(GSaveData[GSaveSlot].data, GSaveData[GSaveSlot].len)) {
                                DirkSimple_log("Restored from save slot #%d!", (int) GSaveSlot);
                            } else {
                                DirkSimple_log("Failed to restore from save slot #%d!", (int) GSaveSlot);
                            }
                        }
                        break;
                    }

                    case SDLK_F5: {
                        DirkSimple_restart();
                        break;
                    }

                    #ifndef __EMSCRIPTEN__
                    case SDLK_F11: {
                        GWantFullscreen = GWantFullscreen ? SDL_FALSE : SDL_TRUE;
                        SDL_SetWindowFullscreen(GWindow, GWantFullscreen ? SDL_WINDOW_FULLSCREEN_DESKTOP : 0);
                        break;
                    }
                    #endif
                }
                break;

            case SDL_KEYUP:
                switch (e.key.keysym.sym) {
                    case SDLK_UP: GKeyInputBits &= ~DIRKSIMPLE_INPUT_UP; break;
                    case SDLK_DOWN: GKeyInputBits &= ~DIRKSIMPLE_INPUT_DOWN; break;
                    case SDLK_LEFT: GKeyInputBits &= ~DIRKSIMPLE_INPUT_LEFT; break;
                    case SDLK_RIGHT: GKeyInputBits &= ~DIRKSIMPLE_INPUT_RIGHT; break;
                    case SDLK_SPACE: GKeyInputBits &= ~DIRKSIMPLE_INPUT_ACTION1; break;
                    case SDLK_LCTRL: GKeyInputBits &= ~DIRKSIMPLE_INPUT_ACTION2; break;  // for now I guess
                    case SDLK_TAB: GKeyInputBits &= ~DIRKSIMPLE_INPUT_COINSLOT; break;
                    case SDLK_RETURN: GKeyInputBits &= ~DIRKSIMPLE_INPUT_START; break;
                }
                break;

            case SDL_CONTROLLERDEVICEADDED:
                if (GGameController == NULL) {
                    GGameController = SDL_GameControllerOpen(e.cdevice.which);
                    if (GGameController) {
                        DirkSimple_log("Opened game controller #%d, '%s'", (int) e.cdevice.which, SDL_GameControllerName(GGameController));
                    }
                }
                break;

            case SDL_CONTROLLERDEVICEREMOVED:
                if (GGameController && (SDL_GameControllerFromInstanceID(e.cdevice.which) == GGameController)) {
                    DirkSimple_log("Closing removed game controller!");
                    SDL_GameControllerClose(GGameController);
                    GGameController = NULL;
                }
                break;

            case SDL_QUIT:
                return SDL_FALSE;
        }
    }

    if (GGameController) {
        #define CHECK_JOYPAD_INPUT(sdlid, dirksimpleid) if (SDL_GameControllerGetButton(GGameController, SDL_CONTROLLER_BUTTON_##sdlid)) { controllerinputbits |= DIRKSIMPLE_INPUT_##dirksimpleid; }
        CHECK_JOYPAD_INPUT(DPAD_UP, UP);
        CHECK_JOYPAD_INPUT(DPAD_DOWN, DOWN);
        CHECK_JOYPAD_INPUT(DPAD_LEFT, LEFT);
        CHECK_JOYPAD_INPUT(DPAD_RIGHT, RIGHT);
        CHECK_JOYPAD_INPUT(A, ACTION1);  // !!! FIXME: what's best here?
        CHECK_JOYPAD_INPUT(X, ACTION2);  // !!! FIXME: what's best here?
        CHECK_JOYPAD_INPUT(BACK, COINSLOT);
        CHECK_JOYPAD_INPUT(START, START);
        #undef CHECK_JOYPAD_INPUT
    }

    DirkSimple_tick(SDL_GetTicks(), GKeyInputBits | controllerinputbits);

    return SDL_TRUE;
}

#if defined(__EMSCRIPTEN__)
static void emscripten_mainloop(void)
{
    if (!mainloop_iteration()) {
        mainloop_shutdown();
        emscripten_cancel_main_loop();  // this should "kill" the app.
    }

    // deal with going fullscreen and resizes.
    if (GWindow != NULL) {
        static int lastw = 0;
        static int lasth = 0;
        const int w = EM_ASM_INT_V({ return window.innerWidth; });
        const int h = EM_ASM_INT_V({ return window.innerHeight; });
        if ((w != lastw) || (h != lasth)) {
            SDL_SetWindowSize(GWindow, w, h);
            lastw = EM_ASM_INT_V({ return window.innerWidth; });
            lasth = EM_ASM_INT_V({ return window.innerHeight; });
        }
    }
}
#endif

void DirkSimple_registercvar(const char *gamename, const char *name, const char *desc, const char *valid_values)
{
    // we don't care about this atm.
}

int main(int argc, char **argv)
{
    const char *gamepath = NULL;
    const char *gamename = NULL;
    char *basedir = NULL;
    char *foundpath = NULL;
    int i;

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_GAMECONTROLLER) == -1) {
        const char *errstr = SDL_GetError();
        SDL_Log("Failed to initialize SDL: %s", errstr);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Failed to initialize SDL", errstr, NULL);  // in case this works.
        return 1;
    }

#ifdef DIRKSIMPLE_FORCE_BASE_DIR  // let Linux distros hardcode this to something under /usr/share, or whatever.
    basedir = SDL_strdup(DIRKSIMPLE_FORCE_BASE_DIR);
#else
    basedir = SDL_GetBasePath();
#endif

    if (basedir == NULL) {
        const char *errstr = SDL_GetError();
        SDL_Log("Failed to determine base dir: %s", errstr);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Failed to determine base dir", errstr, NULL);  // in case this works.
        return 1;
    }

    for (i = 1; i < argc; i++) {
        const char *arg = argv[i];
        if (*arg == '-') {
            while (*arg == '-') {
                arg++;
            }
            if (SDL_strcmp(arg, "fullscreen") == 0) {
                GWantFullscreen = SDL_TRUE;
            } else if (SDL_strcmp(arg, "windowed") == 0) {
                GWantFullscreen = SDL_FALSE;
            } else if (SDL_strcmp(arg, "set") == 0) {
                i += 2;  // eat the next two args.
            }
        } else {
            if (gamepath == NULL) {
                gamepath = arg;
            } else if (gamename == NULL) {
                gamename = arg;
            }
        }
    }

    // just look for an .ogv file in the base dir
    if (!gamepath) {
#ifdef _MSC_VER
        #define UTF16ToUTF8(S) SDL_iconv_string("UTF-8", "UTF-16LE", (const char *)(S), (SDL_wcslen(S) + 1) * sizeof(WCHAR))
        #define UTF8ToUTF16(S) (WCHAR *)SDL_iconv_string("UTF-16LE", "UTF-8", (const char *)(S), SDL_strlen(S) + 1)
        WCHAR *utf16 = UTF8ToUTF16(basedir);
        LPWIN32_FIND_DATAW data;
        HANDLE dirp = FindFirstFileW(utf16, &data);
        SDL_free(utf16);
        if (dirp != INVALID_HANDLE_VALUE) {
            do {
                char *utf8 = UTF16ToUTF8(data.cFileName);
                if (utf8) {
                    const char *ptr = SDL_strrchr(utf8, '.');
                    if (ptr && (SDL_strcmp(ptr, ".ogv") == 0)) {
                        const size_t slen = SDL_strlen(basedir) + SDL_strlen(utf8) + 2;
                        foundpath = (char *) SDL_malloc(slen);
                        if (foundpath) {
                            SDL_snprintf(foundpath, slen, "%s%s", basedir, utf8);
                            gamepath = foundpath;
                        }
                        break;
                    }
                    SDL_free(utf8);
                }
            } while (FindNextFileW(dirp, &data) != 0);
            FindClose(dirp);
        }
        #undef UTF16ToUTF8
        #undef UTF8ToUTF16
#else
        DIR *dirp = opendir(basedir);
        if (dirp) {
            struct dirent *dent;
            while ((dent = readdir(dirp)) != NULL) {
                const char *ptr = SDL_strrchr(dent->d_name, '.');
                if (ptr && (SDL_strcmp(ptr, ".ogv") == 0)) {
                    const size_t slen = SDL_strlen(basedir) + SDL_strlen(dent->d_name) + 2;
                    foundpath = (char *) SDL_malloc(slen);
                    if (foundpath) {
                        SDL_snprintf(foundpath, slen, "%s%s", basedir, dent->d_name);
                        gamepath = foundpath;
                    }
                    break;
                }
            }
            closedir(dirp);
        }
#endif
    }

    if (!gamepath) {
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Can't find a movie file!", "Include an .ogv file with the build or put it on the command line.", NULL);
        SDL_Quit();
        return 1;
    }

    DirkSimple_startup(basedir, gamepath, gamename, DIRKSIMPLE_PIXFMT_IYUV);

    SDL_free(basedir);
    SDL_free(foundpath);

    // cvars are registered now, go ahead and set anything from the command line.
    for (i = 1; i < (argc - 2); i++) {
        const char *arg = argv[i];
        if (*arg == '-') {
            while (*arg == '-') {
                arg++;
            }

            if (SDL_strcmp(arg, "set") == 0) {
                const char *cvarname = argv[++i];
                const char *cvarvalue = argv[++i];
                DirkSimple_setcvar(cvarname, cvarvalue);
            }
        }
    }

#if defined(__EMSCRIPTEN__)
    emscripten_set_main_loop(emscripten_mainloop, 0, 1);
#else
    while (mainloop_iteration()) { /* spin */ }
    mainloop_shutdown();
#endif

    return 0;
}

// end of dirksimple_sdl.c ...

