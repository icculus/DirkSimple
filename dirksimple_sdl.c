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

#include <SDL3/SDL.h>

#define SDL_MAIN_USE_CALLBACKS 1
#include <SDL3/SDL_main.h>

#include "dirksimple_platform.h"

typedef struct SaveSlot
{
    size_t len;
    uint8_t *data;
} SaveSlot;

typedef struct PlayingWave
{
    SDL_AudioStream *stream;
    struct PlayingWave *next;
} PlayingWave;

static SDL_Window *GWindow = NULL;
static SDL_Renderer *GRenderer = NULL;
static SDL_Texture *GLaserDiscTexture = NULL;
static SDL_AudioDeviceID GAudioDeviceID = 0;
static SDL_AudioSpec GAudioSpec;
static int GLaserDiscTextureWidth = 0;
static int GLaserDiscTextureHeight = 0;
static SDL_Gamepad *GGameController = NULL;
static uint8_t GSaveSlot = 0;
static SaveSlot GSaveData[8];
static uint64_t GKeyInputBits = 0;
static bool GWantFullscreen = false;
static PlayingWave *GPlayingWaves = NULL;
static SDL_AudioStream *GDiscAudioStream = NULL;

void *DirkSimple_malloc(size_t len) { return SDL_malloc(len); }
void *DirkSimple_calloc(size_t nmemb, size_t len) { return SDL_calloc(nmemb, len); }
void *DirkSimple_realloc(void *ptr, size_t len) { return SDL_realloc(ptr, len); }
char *DirkSimple_strdup(const char *str) { return SDL_strdup(str); }
void DirkSimple_free(void *ptr) { SDL_free(ptr); }

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
    char *errstr = NULL;
    SDL_asprintf(&errstr, "%s: %s", what, SDL_GetError());
    DirkSimple_panic(errstr ? errstr : what);
}

void DirkSimple_writelog(const char *str)
{
    SDL_Log("%s", str);
}

static long DirkSimple_rwops_read(DirkSimple_Io *io, void *buf, long buflen)
{
    return (long) /* FIXME MIGRATION: double-check if you use the returned value of SDL_RWread() */
        SDL_ReadIO((SDL_IOStream *) io->userdata, buf, buflen);
}

static long DirkSimple_rwops_streamlen(DirkSimple_Io *io)
{
    SDL_IOStream *rwops = (SDL_IOStream *) io->userdata;
    const Sint64 origpos = SDL_TellIO(rwops);
    const long retval = (long) SDL_SeekIO(rwops, 0, SDL_IO_SEEK_END);
    SDL_SeekIO(rwops, origpos, SDL_IO_SEEK_SET);
    return retval;
}

static int DirkSimple_rwops_seek(DirkSimple_Io *io, long absolute_offset)
{
    return SDL_SeekIO((SDL_IOStream *) io->userdata, absolute_offset,
                      SDL_IO_SEEK_SET) != -1;
}

static void DirkSimple_rwops_close(DirkSimple_Io *io)
{
    SDL_CloseIO((SDL_IOStream *) io->userdata);
    DirkSimple_free(io);
}

DirkSimple_Io *DirkSimple_openfile_read(const char *path)
{
    DirkSimple_Io *io = NULL;
    SDL_IOStream *rwops = SDL_IOFromFile(path, "rb");
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

void DirkSimple_audioformat(int channels, int freq)
{
    SDL_zero(GAudioSpec);
    GAudioSpec.freq = freq;
    GAudioSpec.format = SDL_AUDIO_F32;
    GAudioSpec.channels = channels;

    // this does no conversion, we're just using it as a data queue.
    GDiscAudioStream = SDL_CreateAudioStream(&GAudioSpec, &GAudioSpec);
    if (!GDiscAudioStream) {
        DirkSimple_log("Failed to create disc audio stream: %s", SDL_GetError());
        DirkSimple_log("Going on without sound!");
        return;
    }

    GAudioDeviceID = SDL_OpenAudioDevice(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, &GAudioSpec);
    if (GAudioDeviceID == 0) {
        DirkSimple_log("Audio device open failed: %s", SDL_GetError());
        DirkSimple_log("Going on without sound!");
        SDL_DestroyAudioStream(GDiscAudioStream);
        GDiscAudioStream = NULL;
        return;
    }

    SDL_BindAudioStream(GAudioDeviceID, GDiscAudioStream);
}

static bool load_icon_from_dir(SDL_Window *window, const char *dir)
{
    bool retval = false;
    if (dir) {  // oh well if not.
        const size_t slen = SDL_strlen(dir) + 32;
        char *iconpath = (char *) SDL_malloc(slen);
        if (iconpath) {
            SDL_Surface *icon;
            uint8_t *rgba;
            int w, h;
            SDL_snprintf(iconpath, slen, "%sicon.png", dir);
            rgba = DirkSimple_loadpng(iconpath, &w, &h);
            if (rgba) {
                icon = SDL_CreateSurfaceFrom(w, h, SDL_PIXELFORMAT_RGBA8888, rgba, w * 4);
                if (icon) {
                    SDL_SetWindowIcon(window, icon);
                    SDL_DestroySurface(icon);
                    retval = true;
                }
                DirkSimple_free(rgba);
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
    Uint32 flags = SDL_WINDOW_HIDDEN | SDL_WINDOW_RESIZABLE | SDL_WINDOW_HIGH_PIXEL_DENSITY;
    if (GWantFullscreen) {
        flags = SDL_WINDOW_FULLSCREEN;
    }

    GWindow = SDL_CreateWindow(gametitle ? gametitle : "DirkSimple", width, height, flags);
    if (!GWindow) {
        sdlpanic("Failed to create window");
    }

    load_icon(GWindow);

    GRenderer = SDL_CreateRenderer(GWindow, NULL);
    if (!GRenderer) {
        sdlpanic("Failed to create renderer");
    }

    SDL_HideCursor();
    SDL_SetRenderDrawColor(GRenderer, 0, 0, 0, 255);
    SDL_SetRenderLogicalPresentation(GRenderer, width, height,
                                     SDL_LOGICAL_PRESENTATION_LETTERBOX);
    SDL_RenderClear(GRenderer);
    SDL_RenderPresent(GRenderer);
    SDL_ShowWindow(GWindow);
    SDL_RenderClear(GRenderer);
    SDL_RenderPresent(GRenderer);

    DirkSimple_log("SDL renderer backend: %s", SDL_GetRendererName(GRenderer));

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
    SDL_PutAudioStreamData(GDiscAudioStream, pcm, numframes * sizeof (float) * GAudioSpec.channels);
}

void DirkSimple_cleardiscaudio(void)
{
    SDL_ClearAudioStream(GDiscAudioStream);
}

void SDL_AppQuit(void *appstate, SDL_AppResult result)
{
    SDL_DestroyTexture(GLaserDiscTexture);
    SDL_DestroyRenderer(GRenderer);
    SDL_DestroyWindow(GWindow);

    SDL_CloseAudioDevice(GAudioDeviceID);

    SDL_DestroyAudioStream(GDiscAudioStream);

    while (GPlayingWaves != NULL) {
        PlayingWave *next = GPlayingWaves->next;
        SDL_DestroyAudioStream(GPlayingWaves->stream);
        DirkSimple_free(GPlayingWaves);
        GPlayingWaves = next;
    }

    if (GGameController) {
        SDL_CloseGamepad(GGameController);
    }

    DirkSimple_shutdown();
}

void DirkSimple_beginframe(void)
{
    if (GRenderer) {
        SDL_SetRenderDrawColor(GRenderer, 0, 0, 0, 255);
        SDL_RenderClear(GRenderer);
        SDL_RenderTexture(GRenderer, GLaserDiscTexture, NULL, NULL);
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
    const SDL_FRect srcrect = { (float) sx, (float) sy, (float) sw, (float) sh };
    const SDL_FRect dstrect = { (float) dx, (float) dy, (float) dw, (float) dh };

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
        SDL_SetTextureScaleMode(texture, SDL_SCALEMODE_NEAREST);
        #endif
        SDL_UpdateTexture(texture, NULL, sprite->rgba, sprite->width * 4);
    }

    SDL_SetTextureColorMod(texture, rmod, gmod, bmod);
    SDL_RenderTexture(GRenderer, texture, &srcrect, &dstrect);
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
    PlayingWave *pw = GPlayingWaves;
    while (pw != NULL) {
        if (SDL_GetAudioStreamAvailable(pw->stream) == 0) {  // if zero, it's free to reuse.
            break;
        }
        pw = pw->next;
    }

    if (pw == NULL) {  // need a new audio stream!
        pw = DirkSimple_xmalloc(sizeof (PlayingWave));
        pw->stream = SDL_CreateAudioStream(&GAudioSpec, NULL);
        if (pw->stream == NULL) {
            SDL_free(pw);
            return;
        } else if (!SDL_BindAudioStream(GAudioDeviceID, pw->stream)) {
            SDL_DestroyAudioStream(pw->stream);
            SDL_free(pw);
            return;
        }
        pw->next = GPlayingWaves;
        GPlayingWaves = pw;
    }

    SDL_PutAudioStreamData(pw->stream, wave->pcm, wave->numframes * GAudioSpec.channels * SDL_AUDIO_BYTESIZE(GAudioSpec.format));
    SDL_FlushAudioStream(pw->stream);
}

void DirkSimple_destroywave(DirkSimple_Wave *wave)
{
    // does nothing at the moment.
}

SDL_AppResult SDL_AppEvent(void *appstate, SDL_Event *e)
{
    switch (e->type) {
        case SDL_EVENT_KEY_DOWN:
            switch (e->key.key) {
                case SDLK_UP: GKeyInputBits |= DIRKSIMPLE_INPUT_UP; break;
                case SDLK_DOWN: GKeyInputBits |= DIRKSIMPLE_INPUT_DOWN; break;
                case SDLK_LEFT: GKeyInputBits |= DIRKSIMPLE_INPUT_LEFT; break;
                case SDLK_RIGHT: GKeyInputBits |= DIRKSIMPLE_INPUT_RIGHT; break;
                case SDLK_SPACE: GKeyInputBits |= DIRKSIMPLE_INPUT_ACTION1; break;
                case SDLK_LCTRL: GKeyInputBits |= DIRKSIMPLE_INPUT_ACTION2; break;  // for now I guess
                case SDLK_TAB: GKeyInputBits |= DIRKSIMPLE_INPUT_COINSLOT; break;
                case SDLK_RETURN: GKeyInputBits |= DIRKSIMPLE_INPUT_START; break;

                case SDLK_ESCAPE:
                    return SDL_APP_SUCCESS;  // !!! FIXME: remove this later?

                case SDLK_LEFTBRACKET:
                case SDLK_RIGHTBRACKET:
                    if (e->key.key == SDLK_LEFTBRACKET) {
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
                    GWantFullscreen = !GWantFullscreen;
                    SDL_SetWindowFullscreen(GWindow, GWantFullscreen);
                    break;
                }
                #endif
            }
            break;

        case SDL_EVENT_KEY_UP:
            switch (e->key.key) {
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

        case SDL_EVENT_GAMEPAD_ADDED:
            if (GGameController == NULL) {
                GGameController = SDL_OpenGamepad(e->gdevice.which);
                if (GGameController) {
                    DirkSimple_log("Opened game controller #%d, '%s'", (int) e->gdevice.which, SDL_GetGamepadName(GGameController));
                }
            }
            break;

        case SDL_EVENT_GAMEPAD_REMOVED:
            if (GGameController && (SDL_GetGamepadFromID(e->gdevice.which) == GGameController)) {
                DirkSimple_log("Closing removed game controller!");
                SDL_CloseGamepad(GGameController);
                GGameController = NULL;
            }
            break;

        case SDL_EVENT_QUIT:
            return SDL_APP_SUCCESS;
    }

    return SDL_APP_CONTINUE;
}

SDL_AppResult SDL_AppIterate(void *appstate)
{
    uint64_t controllerinputbits = 0;

    if (GGameController) {
        #define CHECK_JOYPAD_INPUT(sdlid, dirksimpleid) if (SDL_GetGamepadButton(GGameController, SDL_GAMEPAD_BUTTON_##sdlid)) { controllerinputbits |= DIRKSIMPLE_INPUT_##dirksimpleid; }
        CHECK_JOYPAD_INPUT(DPAD_UP, UP);
        CHECK_JOYPAD_INPUT(DPAD_DOWN, DOWN);
        CHECK_JOYPAD_INPUT(DPAD_LEFT, LEFT);
        CHECK_JOYPAD_INPUT(DPAD_RIGHT, RIGHT);
        CHECK_JOYPAD_INPUT(SOUTH, ACTION1);  // !!! FIXME: what's best here?
        CHECK_JOYPAD_INPUT(WEST, ACTION2);  // !!! FIXME: what's best here?
        CHECK_JOYPAD_INPUT(BACK, COINSLOT);
        CHECK_JOYPAD_INPUT(START, START);
        #undef CHECK_JOYPAD_INPUT
    }

    DirkSimple_tick(SDL_GetTicks(), GKeyInputBits | controllerinputbits);

#if defined(__EMSCRIPTEN__)
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
#endif

    return SDL_APP_CONTINUE;
}

void DirkSimple_registercvar(const char *gamename, const char *name, const char *desc, const char *valid_values)
{
    // we don't care about this atm.
}

static SDL_EnumerationResult SDLCALL find_movie_files(void *userdata, const char *dirname, const char *fname)
{
    char **pfoundpath = (char **) userdata;
    const char *ptr = SDL_strrchr(fname, '.');
    if (ptr && (SDL_strcasecmp(ptr, ".ogv") == 0)) {
        return (SDL_asprintf(pfoundpath, "%s%s", dirname, fname) == -1) ? SDL_ENUM_FAILURE : SDL_ENUM_SUCCESS;
    }
    return SDL_ENUM_CONTINUE;
}

SDL_AppResult SDL_AppInit(void **appstate, int argc, char *argv[])
{
    const char *gamepath = NULL;
    const char *gamename = NULL;
    const char *basedir = NULL;
    char *foundpath = NULL;
    int i;

    if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_GAMEPAD)) {
        const char *errstr = SDL_GetError();
        SDL_Log("Failed to initialize SDL: %s", errstr);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Failed to initialize SDL", errstr, NULL);  // in case this works.
        return SDL_APP_FAILURE;
    }

#ifdef DIRKSIMPLE_FORCE_BASE_DIR  // let Linux distros hardcode this to something under /usr/share, or whatever.
    basedir = DIRKSIMPLE_FORCE_BASE_DIR;
#else
    basedir = SDL_GetBasePath();
#endif

    if (basedir == NULL) {
        const char *errstr = SDL_GetError();
        SDL_Log("Failed to determine base dir: %s", errstr);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Failed to determine base dir", errstr, NULL);  // in case this works.
        return SDL_APP_FAILURE;
    }

    for (i = 1; i < argc; i++) {
        const char *arg = argv[i];
        if (*arg == '-') {
            while (*arg == '-') {
                arg++;
            }
            if (SDL_strcmp(arg, "fullscreen") == 0) {
                GWantFullscreen = true;
            } else if (SDL_strcmp(arg, "windowed") == 0) {
                GWantFullscreen = false;
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
        SDL_EnumerateDirectory(basedir, find_movie_files, &foundpath);
        gamepath = foundpath;
    }

    if (!gamepath) {
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Can't find a movie file!", "Include an .ogv file with the build or put it on the command line.", NULL);
        SDL_Quit();
        return SDL_APP_FAILURE;
    }

    DirkSimple_startup(basedir, gamepath, gamename, DIRKSIMPLE_PIXFMT_IYUV);

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

    return SDL_APP_CONTINUE;
}

// end of dirksimple_sdl.c ...

