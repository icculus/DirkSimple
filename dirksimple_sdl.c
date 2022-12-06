/**
 * Dirk Simple; a player for FMV games.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#include "SDL.h"

#include "dirksimple_platform.h"

static SDL_Window *GWindow = NULL;
static SDL_Renderer *GRenderer = NULL;
static SDL_Texture *GLaserDiscTexture = NULL;
static SDL_AudioDeviceID GAudioDeviceID = 0;
static int GAudioChannels = 0;
static int GLaserDiscTextureWidth = 0;
static int GLaserDiscTextureHeight = 0;

void DirkSimple_panic(const char *str)
{
    SDL_Log("DirkSimple PANIC: %s", str);
    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "DirkSimple PANIC", str, GWindow);
    SDL_Quit();
    exit(1);
}

static DIRKSIMPLE_NORETURN void sdlpanic(const char *what)
{
    char *errstr = NULL;
    SDL_asprintf(&errstr, "%s: %s", what, SDL_GetError());
    DirkSimple_panic(errstr ? errstr : what);
}

extern void DirkSimple_writelog(const char *str)
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
    long retval = -1;
    retval = (long) SDL_RWseek(rwops, 0, RW_SEEK_END);
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

void DirkSimple_audioformat(int channels, int freq)
{
    SDL_AudioSpec spec;
    SDL_zero(spec);
    spec.freq = freq;
    spec.format = AUDIO_F32SYS;
    spec.channels = channels;
    spec.samples = 256;
    spec.callback = NULL;
    GAudioChannels = channels;
    GAudioDeviceID = SDL_OpenAudioDevice(NULL, 0, &spec, NULL, 0);
    if (GAudioDeviceID == 0) {
        DirkSimple_log("Audio device open failed: %s", SDL_GetError());
        DirkSimple_log("Going on without sound!");
    }
    SDL_PauseAudioDevice(GAudioDeviceID, 0);
}

void DirkSimple_videoformat(const char *gametitle, uint32_t width, uint32_t height)
{
    GWindow = SDL_CreateWindow(gametitle ? gametitle : "DirkSimple", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, SDL_WINDOW_RESIZABLE);  // !!! FIXME: fullscreen desktop?
    if (!GWindow) {
        sdlpanic("Failed to create window");
    }

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

    GLaserDiscTexture = SDL_CreateTexture(GRenderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING, (int) width, (int) height);
    if (!GLaserDiscTexture) {
        sdlpanic("Failed to create laserdisc texture");
    }

    // initialize the YUV texture to black.
    Uint8 *pixels = DirkSimple_xcalloc(1, (width * height) + ((width * height) / 2));
    SDL_memset(pixels + (width*height), 128, (width * height) / 2);
    SDL_UpdateTexture(GLaserDiscTexture, NULL, pixels, width);  // make sure it's zeroed out.
    free(pixels);

    GLaserDiscTextureWidth = width;
    GLaserDiscTextureHeight = height;
}

void DirkSimple_discvideo(const uint8_t *iyuv)
{
    SDL_UpdateTexture(GLaserDiscTexture, NULL, iyuv, GLaserDiscTextureWidth);
}

void DirkSimple_discaudio(const float *pcm, int numframes)
{
    SDL_QueueAudio(GAudioDeviceID, pcm, numframes * sizeof (float) * GAudioChannels);
}

void DirkSimple_cleardiscaudio(void)
{
    if (GAudioDeviceID) {
        SDL_ClearQueuedAudio(GAudioDeviceID);
    }
}

static void render_frame()
{
    if (!GRenderer) {
        return;  // no video yet.
    }

    SDL_RenderClear(GRenderer);
    SDL_RenderCopy(GRenderer, GLaserDiscTexture, NULL, NULL);
    SDL_RenderPresent(GRenderer);
}

int main(int argc, char **argv)
{
    const char *gamepath = NULL;
    SDL_bool keep_going = SDL_TRUE;
    uint64_t keyinputbits = 0;
    uint64_t controllerinputbits = 0;

    if (argc != 2) {
        SDL_Log("USAGE: %s <path/to/game.ogv>", argv[0]);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "USAGE", "USAGE: dirksimple <path/to/game.ogv>", NULL);
        return 1;
    }

    gamepath = argv[1];

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) == -1) {
        const char *errstr = SDL_GetError();
        SDL_Log("Failed to initialize SDL: %s", errstr);
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Failed to initialize SDL", errstr, NULL);  // in case this works.
        return 1;
    }

    DirkSimple_startup(gamepath, NULL);  // !!! FIXME: add --gamename option?

    while (keep_going) {
        SDL_Event e;

        while (SDL_PollEvent(&e)) {
            switch (e.type) {
                case SDL_KEYDOWN:
                    switch (e.key.keysym.sym) {
                        case SDLK_UP: keyinputbits |= DIRKSIMPLE_INPUT_UP; break;
                        case SDLK_DOWN: keyinputbits |= DIRKSIMPLE_INPUT_DOWN; break;
                        case SDLK_LEFT: keyinputbits |= DIRKSIMPLE_INPUT_LEFT; break;
                        case SDLK_RIGHT: keyinputbits |= DIRKSIMPLE_INPUT_RIGHT; break;
                        case SDLK_SPACE: keyinputbits |= DIRKSIMPLE_INPUT_ACTION1; break;
                        case SDLK_a: keyinputbits |= DIRKSIMPLE_INPUT_ACTION2; break;  // for now I guess
                        case SDLK_TAB: keyinputbits |= DIRKSIMPLE_INPUT_COINSLOT; break;
                        case SDLK_RETURN: keyinputbits |= DIRKSIMPLE_INPUT_START; break;
                        case SDLK_ESCAPE: keep_going = SDL_FALSE; break;  // !!! FIXME: remove this later.
                    }
                    break;

                case SDL_KEYUP:
                    switch (e.key.keysym.sym) {
                        case SDLK_UP: keyinputbits &= ~DIRKSIMPLE_INPUT_UP; break;
                        case SDLK_DOWN: keyinputbits &= ~DIRKSIMPLE_INPUT_DOWN; break;
                        case SDLK_LEFT: keyinputbits &= ~DIRKSIMPLE_INPUT_LEFT; break;
                        case SDLK_RIGHT: keyinputbits &= ~DIRKSIMPLE_INPUT_RIGHT; break;
                        case SDLK_SPACE: keyinputbits &= ~DIRKSIMPLE_INPUT_ACTION1; break;
                        case SDLK_a: keyinputbits &= ~DIRKSIMPLE_INPUT_ACTION2; break;  // for now I guess
                        case SDLK_TAB: keyinputbits &= ~DIRKSIMPLE_INPUT_COINSLOT; break;
                        case SDLK_RETURN: keyinputbits &= ~DIRKSIMPLE_INPUT_START; break;
                    }
                    break;

                case SDL_QUIT:
                    keep_going = SDL_FALSE;
                    break;
            }
        }

        DirkSimple_tick(SDL_GetTicks64(), keyinputbits | controllerinputbits);
        render_frame();
    }

    DirkSimple_shutdown();

    SDL_DestroyTexture(GLaserDiscTexture);
    SDL_DestroyRenderer(GRenderer);
    SDL_DestroyWindow(GWindow);

    SDL_CloseAudioDevice(GAudioDeviceID);

    SDL_Quit();
    return 0;
}

// end of dirksimple_sdl.c ...

