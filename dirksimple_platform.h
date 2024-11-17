/**
 * DirkSimple; a dirt-simple player for FMV games.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#ifndef INCL_DIRKSIMPLE_PLATFORM_H
#define INCL_DIRKSIMPLE_PLATFORM_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdarg.h>

#if defined(_WIN32) || defined(__OS2__)
#define DIRSEP "\\"
#else
#define DIRSEP "/"
#endif

#if defined(__GNUC__) || defined(__clang__)
#define DIRKSIMPLE_NORETURN __attribute__((noreturn))
#elif defined(_MSC_VER)
#define DIRKSIMPLE_NORETURN __declspec(noreturn)
#else
#define DIRKSIMPLE_NORETURN
#endif

#if defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
#define DIRKSIMPLE_MULTITHREADED 0
#else
#define DIRKSIMPLE_MULTITHREADED 1
#endif

// We might change this later for second players, lightguns, etc. Always use the macros and not hardcoded values!
#define DIRKSIMPLE_INPUT_UP       (1 << 0)
#define DIRKSIMPLE_INPUT_DOWN     (1 << 1)
#define DIRKSIMPLE_INPUT_LEFT     (1 << 2)
#define DIRKSIMPLE_INPUT_RIGHT    (1 << 3)
#define DIRKSIMPLE_INPUT_ACTION1  (1 << 4)
#define DIRKSIMPLE_INPUT_ACTION2  (1 << 5)
#define DIRKSIMPLE_INPUT_COINSLOT (1 << 6)
#define DIRKSIMPLE_INPUT_START    (1 << 7)

typedef enum DirkSimple_PixFmt
{
    DIRKSIMPLE_PIXFMT_YV12,  /* NTSC colorspace, planar YCrCb 4:2:0 */
    DIRKSIMPLE_PIXFMT_IYUV,  /* NTSC colorspace, planar YCbCr 4:2:0 */
    DIRKSIMPLE_PIXFMT_RGB,   /* 24 bits packed pixel RGB */
    DIRKSIMPLE_PIXFMT_RGBA,  /* 32 bits packed pixel RGBA (full alpha). */
    DIRKSIMPLE_PIXFMT_BGRA,  /* 32 bits packed pixel BGRA (full alpha). */
    DIRKSIMPLE_PIXFMT_RGB565 /* 16 bits packed pixel RGB565. */
} DirkSimple_PixFmt;

// dirksimple.c implements these, which you can call into...

// You implement main() or whatever, and call this with the path to the game's .ogv file to start.
// `basedir` is where to load files this app needs (scripts, icons, etc).
// `gamename` can specify the game type if the gamepath's filename isn't in the format of "gamename.ext",
//  but can be NULL if you want us to figure that out for you.
// `pixfmt` tells DirkSimple_discvideo to provide a specific pixel format.
// This loads things, starts things going, and returns. If there's a failure, it
// will call DirkSimple_panic. There is no graceful failure here.
extern void DirkSimple_startup(const char *basedir, const char *gamepath, const char *gamename, DirkSimple_PixFmt pixfmt);

// You call this frequently (once per frame or more).
//  `monotonic_ms` is current time in milliseconds. It must increase reliably, and doesn't matter what value it starts at.
//  `inputbits` is a bitmask of DIRKSIMPLE_INPUT_* flags.
extern void DirkSimple_tick(uint64_t monotonic_ms, uint64_t inputbits);

// You call this once when done with a game to clean up.
extern void DirkSimple_shutdown(void);

// Log a formatted string. This will eventually call DirkSimple_logwrite() in the platform code with the final formatted string.
extern void DirkSimple_log(const char *fmt, ...);

// These just wrap the platform malloc, etc, but call DirkSimple_panic if they fail.
extern void *DirkSimple_xmalloc(size_t len);
extern void *DirkSimple_xcalloc(size_t nmemb, size_t len);
extern void *DirkSimple_xrealloc(void *ptr, size_t len);
extern char *DirkSimple_xstrdup(const char *str);

extern void DirkSimple_restart(void);
extern size_t DirkSimple_serialize(void *data, size_t len);
extern int DirkSimple_unserialize(const void *data, size_t len);

// these are valid between a successful DirkSimple_startup and DirkSimple_shutdown.
extern const char *DirkSimple_gamename(void);
extern const char *DirkSimple_gamedir(void);  // root of current game's data
extern const char *DirkSimple_datadir(void);  // root of all DirkSimple data

// returns RGBA8 data for the .BMP file at `fname`. This is not super-robust,
//  but it's only meant to load small assets we control. Returns NULL on
//  error. Fills in `*_w` and `*_h` with image dimensions in pixels on
//  success. Call DirkSimple_free() on the return value when done with it.
extern uint8_t *DirkSimple_loadbmp(const char *fname, int *_w, int *_h);
extern uint8_t *DirkSimple_loadpng(const char *fname, int *_w, int *_h);

extern void DirkSimple_setcvar(const char *name, const char *newvalue);

// Your platform layer implements these, which dirksimple.c calls into...

/* simple allocators, in case you don't want to use malloc */
extern void *DirkSimple_malloc(size_t len);
extern void *DirkSimple_calloc(size_t nmemb, size_t len);
extern void *DirkSimple_realloc(void *ptr, size_t len);
extern char *DirkSimple_strdup(const char *str);
extern void DirkSimple_free(void *ptr);

// Show an error, then terminate the process, don't return. This can
// be called at any time!
extern DIRKSIMPLE_NORETURN void DirkSimple_panic(const char *str);

// Write a line of text to the logging facilities. No newlines included in `str`!
extern void DirkSimple_writelog(const char *str);

// abstract file i/o interface...
typedef struct DirkSimple_Io DirkSimple_Io;

struct DirkSimple_Io
{
    long (*read)(DirkSimple_Io *io, void *buf, long buflen);
    long (*streamlen)(DirkSimple_Io *io);
    int (*seek)(DirkSimple_Io *io, long absolute_offset);
    void (*close)(DirkSimple_Io *io);
    void *userdata;
};

extern DirkSimple_Io *DirkSimple_openfile_read(const char *path);

// This is called once, near startup, to tell you what format audio and video data will be supplied in.
// This is async! We will not have this information during DirkSimple_startup, as we have to
// wait for the "laserdisc" video file to supply it. Be prepared to set up your outputs
// at some arbitrary point, possibly after a few calls to DirkSimple_tick.
extern void DirkSimple_audioformat(int channels, int freq);
extern void DirkSimple_videoformat(const char *gametitle, uint32_t width, uint32_t height, double fps);

// A new frame from the "laserdisc." These won't show up every call to DirkSimple_tick, so if you need
//  to refresh the display at specific times, you should redraw with this data more than once.
//  You are expected to copy iyuv if you need to store it.
extern void DirkSimple_discvideo(const uint8_t *iyuv);

// More PCM audio data from the "laserdisc." These won't show up every call to DirkSimple_tick.
// If the laserdisc wants to seek elsewhere, DiskSimple_cleardiscaudio will be called, to inform you
// that previously queued audio should be dumped without being played.
// `pcm` points to `numframes` sample frames of float32 PCM. So if this is stereo data and `numframes`
// is 1, then there are exactly 2 float values available (numframes * numchannels)..
extern void DirkSimple_discaudio(const float *pcm, int numframes);

extern void DirkSimple_cleardiscaudio(void);

// Called once during DirkSimple_tick, if the laserdisc is ready to play.
//  The platform layer should prepare the screen for a new frame of video
//  and render the current laserdisc frame. Other drawing commands might
//  follow that render on top of this, and will finish with a call to
//  DirkSimple_endframe.
extern void DirkSimple_beginframe(void);

// Called once during DirkSimple_tick, if DirkSimple_beginframe was called.
// This signifies that rendering is complete and the frame should be presented.
extern void DirkSimple_endframe(void);

extern void DirkSimple_clearscreen(uint8_t r, uint8_t g, uint8_t b);

typedef struct DirkSimple_Sprite DirkSimple_Sprite;

struct DirkSimple_Sprite
{
    char *name;
    int width;
    int height;
    uint8_t *rgba;
    void *platform_handle;
    DirkSimple_Sprite *next;
};

// Platform layer should build out any thing it needs (textures, etc) and cache them on
//  `platform_handle`, then draw the sprite as requested over the latest laserdisc frame.
// There is an alpha channel, but it's legal to treat it as full or empty
//  for simplicity here...it's meant to be a mask, not proper blending.
extern void DirkSimple_drawsprite(DirkSimple_Sprite *sprite, int sx, int sy, int sw, int sh, int dx, int dy, int dw, int dh, uint8_t rmod, uint8_t gmod, uint8_t bmod);

// This is just to clear out any `platform_handle` stuff. The engine cleans up the rest.
extern void DirkSimple_destroysprite(DirkSimple_Sprite *sprite);


typedef struct DirkSimple_Wave DirkSimple_Wave;

// this always comes through in the same format as the laserdisc audio.
struct DirkSimple_Wave
{
    char *name;
    int numframes;
    float *pcm;
    uint64_t duration_ticks;
    uint64_t ticks_when_available;
    void *platform_handle;
    DirkSimple_Wave *next;
};

// Platform layer should build out any thing it needs and cache them on
//  `platform_handle`, then mix the wave as requested over the latest laserdisc audio.
// This is always in the same format as the laserdisc audio (same channels, same samplerate, etc).
extern void DirkSimple_playwave(DirkSimple_Wave *wave);

// This is just to clear out any `platform_handle` stuff. The engine cleans up the rest.
extern void DirkSimple_destroywave(DirkSimple_Wave *wave);

// copy these strings if you need to keep them.
extern void DirkSimple_registercvar(const char *gamename, const char *name, const char *desc, const char *valid_values);

#endif // INCL_DIRKSIMPLE_PLATFORM_H

// end of dirksimple_platform.h ...

