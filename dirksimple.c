/**
 * DirkSimple; a dirt-simple player for FMV games.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#include "dirksimple_platform.h"

#include "theoraplay.h"
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#define DIRKSIMPLE_LUA_NAMESPACE "DirkSimple"

// "included in all copies or substantial portions of the Software"
static const char *GLuaLicense =
"Lua:\n"
"\n"
"Copyright (C) 1994-2008 Lua.org, PUC-Rio.\n"
"\n"
"Permission is hereby granted, free of charge, to any person obtaining a copy\n"
"of this software and associated documentation files (the \"Software\"), to deal\n"
"in the Software without restriction, including without limitation the rights\n"
"to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n"
"copies of the Software, and to permit persons to whom the Software is\n"
"furnished to do so, subject to the following conditions:\n"
"\n"
"The above copyright notice and this permission notice shall be included in\n"
"all copies or substantial portions of the Software.\n"
"\n"
"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE\n"
"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n"
"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n"
"THE SOFTWARE.\n"
"\n";


typedef enum RenderPrimitive
{
    RENDPRIM_CLEAR,
    RENDPRIM_SPRITE,
    RENDPRIM_SOUND,
} RenderPrimitive;

typedef struct RenderCommand
{
    RenderPrimitive prim;
    union
    {
        struct
        {
            uint8_t r, g, b;
        } clear;
        struct
        {
            char name[32];
            int32_t sx, sy, sw, sh, dx, dy, dw, dh;
            uint8_t r, g, b;
        } sprite;
        struct
        {
            char name[32];
        } sound;
    } data;
} RenderCommand;


static char *GGameName = NULL;
static char *GGamePath = NULL;
static char *GDataDir = NULL;
static char *GGameDir = NULL;
static THEORAPLAY_Decoder *GDecoder = NULL;
static THEORAPLAY_Io GTheoraplayIo;
static lua_State *GLua = NULL;
static uint64_t GPreviousInputBits = 0;
static int GDiscoveredVideoFormat = 0;
static int GDiscoveredAudioFormat = 0;
static int GAudioChannels = 0;
static int GAudioFreq = 0;
static uint64_t GTicks = 0;         // Current ticks into the game, increases each iteration.
static uint64_t GTicksOffset = 0;   // offset from monotonic clock where we started.
static uint32_t GFrameMS = 0;       // milliseconds each video frame takes.
static int64_t GSeekToTicksOffset = 0;
static uint64_t GClipStartMs = 0;   // Milliseconds into video stream that starts this clip.
static uint64_t GClipStartTicks = 0;  // GTicks when clip started playing
static int GHalted = 0;
static int GShowingSingleFrame = 0;
static unsigned int GSeekGeneration = 0;
static int GNeedInitialLuaTick = 1;
static const THEORAPLAY_VideoFrame *GPendingVideoFrame = NULL;
static DirkSimple_Sprite *GSprites = NULL;
static DirkSimple_Wave *GWaves = NULL;
static RenderCommand *GRenderCommands = NULL;
static int GNumRenderCommands = 0;
static int GNumAllocatedRenderCommands = 0;
static uint8_t *GBlankVideoFrame = NULL;

static void out_of_memory(void)
{
    DirkSimple_panic("Out of memory!");
}

void *DirkSimple_xmalloc(size_t len)
{
    void *retval = DirkSimple_malloc(len);
    if (!retval) {
        out_of_memory();
    }
    return retval;
}

void *DirkSimple_xcalloc(size_t nmemb, size_t len)
{
    void *retval = DirkSimple_calloc(nmemb, len);
    if (!retval) {
        out_of_memory();
    }
    return retval;
}

void *DirkSimple_xrealloc(void *ptr, size_t len)
{
    void *retval = DirkSimple_realloc(ptr, len);
    if (!retval && (len > 0)) {
        out_of_memory();
    }
    return retval;
}

char *DirkSimple_xstrdup(const char *str)
{
    char *retval = DirkSimple_strdup(str);
    if (!retval) {
        out_of_memory();
    }
    return retval;
}

const char *DirkSimple_gamename(void) { return GGameName; }
const char *DirkSimple_datadir(void) { return GDataDir; }
const char *DirkSimple_gamedir(void) { return GGameDir; }

void DirkSimple_log(const char *fmt, ...)
{
    char *str = NULL;
    va_list ap;
    size_t len;

    va_start(ap, fmt);
    len = vsnprintf(NULL, 0, fmt, ap);
    va_end(ap);

    str = DirkSimple_xmalloc(len + 1);
    va_start(ap, fmt);
    vsnprintf(str, len + 1, fmt, ap);
    va_end(ap);

    DirkSimple_writelog(str);
    DirkSimple_free(str);
}


static long theoraplayiobridge_read(THEORAPLAY_Io *io, void *buf, long buflen)
{
    DirkSimple_Io *dio = (DirkSimple_Io *) io->userdata;
    return dio->read(dio, buf, buflen);
}

static long theoraplayiobridge_streamlen(THEORAPLAY_Io *io)
{
    DirkSimple_Io *dio = (DirkSimple_Io *) io->userdata;
    return dio->streamlen(dio);
}

static int theoraplayiobridge_seek(THEORAPLAY_Io *io, long absolute_offset)
{
    DirkSimple_Io *dio = (DirkSimple_Io *) io->userdata;
    return dio->seek(dio, absolute_offset);
}

static void theoraplayiobridge_close(THEORAPLAY_Io *io)
{
    DirkSimple_Io *dio = (DirkSimple_Io *) io->userdata;
    return dio->close(dio);
}

static uint8_t *invalid_media(const char *fname, const char *err)
{
    DirkSimple_log("Failed to load '%s': %s", fname, err);
    return NULL;
}

uint8_t *DirkSimple_loadmedia(const char *fname, long *flen)
{
    DirkSimple_Io *io = DirkSimple_openfile_read(fname);
    if (!io) {
        return invalid_media(fname, "Couldn't open file for reading");
    }

    *flen = io->streamlen(io);
    uint8_t *fbuf = (uint8_t *) DirkSimple_malloc(*flen);
    if (!fbuf) {
        return invalid_media(fname, "Out of memory");
    }

    const long br = io->read(io, fbuf, *flen);
    io->close(io);
    if (br != *flen) {
        DirkSimple_free(fbuf);
        return invalid_media(fname, "couldn't read whole file into memory");
    }
    return fbuf;
}

static uint32_t readui32le(const uint8_t **pptr)
{
    const uint8_t *ptr = *pptr;
    uint32_t retval = (uint32_t) ptr[0];
    retval |= ((uint32_t) ptr[1]) << 8;
    retval |= ((uint32_t) ptr[2]) << 16;
    retval |= ((uint32_t) ptr[3]) << 24;
    *pptr += sizeof (retval);
    return retval;
}

static uint16_t readui16le(const uint8_t **pptr)
{
    const uint8_t *ptr = *pptr;
    uint16_t retval = (uint16_t) ptr[0];
    retval |= ((uint16_t) ptr[1]) << 8;
    *pptr += sizeof (retval);
    return retval;
}

static uint8_t *loadbmp_from_memory(const char *fname, const uint8_t *buf, int buflen, int *_w, int *_h)
{
    const uint8_t *ptr = buf;

    *_w = *_h = 0;

    if (buflen < 50) {
        return invalid_media(fname, "Not a .BMP file");
    }

    if ((ptr[0] != 'B') || (ptr[1] != 'M')) {
        return invalid_media(fname, "Not a .BMP file");
    }
    ptr += 10;
    const uint32_t offset_bits = readui32le(&ptr);
    const uint32_t infolen = readui32le(&ptr);
    if (offset_bits > buflen) {
        return invalid_media(fname, "Incomplete or corrupt .BMP file");
    } else if ((infolen + 10) > buflen) {
        return invalid_media(fname, "Incomplete or corrupt .BMP file");
    } else if (infolen < 40) {  // not a standard BITMAPINFOHEADER.
        return invalid_media(fname, "Unsupported .BMP format");
    } else if (infolen == 64) {  // this is some ancient, incompatible OS/2 thing.
        return invalid_media(fname, "Unsupported .BMP format");
    }

    const uint32_t bmpwidth = readui32le(&ptr);
    const uint32_t bmpheight = readui32le(&ptr);
    if ((bmpwidth > 1024) || (bmpheight > 1024)) {
        return invalid_media(fname, "Image is too big");  // this is just an arbitrary limit.
    } else if ((bmpwidth == 0) || (bmpheight == 0)) {
        return invalid_media(fname, "Image is zero pixels in size");
    } else if ((offset_bits + (bmpwidth * bmpheight * 4)) > buflen) {
        return invalid_media(fname, "Incomplete or corrupt .BMP file");
    }

    ptr += 2;  // skip planes
    const uint16_t bitcount = readui16le(&ptr);
    if (bitcount != 32) {
        return invalid_media(fname, "Only 32bpp .BMP files supported");
    }

    const uint32_t compression = readui32le(&ptr);
    if ((compression != 0) && (compression != 3)) {
        return invalid_media(fname, "Only uncompressed RGB .BMP files supported");
    }

    // we don't check the color masks; we assume they match what we want,
    // and checking them just to verify is a lot of compatibility tapdancing.

    uint8_t *pixels = (uint8_t *) DirkSimple_xmalloc(bmpwidth * bmpheight * 4);

    // of course the stupid pixels are upside down in a bmp file.
    const size_t rowlen = bmpwidth * 4;
    const uint8_t *src = (buf + offset_bits) + (rowlen * (bmpheight - 1));
    uint8_t *dst = pixels;
    for (int y = 0; y < bmpheight; y++) {
        memcpy(dst, src, rowlen);
        dst += rowlen;
        src -= rowlen;
    }

    *_w = (int) bmpwidth;
    *_h = (int) bmpheight;
    return pixels;
}

uint8_t *DirkSimple_loadbmp(const char *fname, int *_w, int *_h)
{
    long flen = 0;
    uint8_t *fbuf = DirkSimple_loadmedia(fname, &flen);
    uint8_t *pixels = loadbmp_from_memory(fname, fbuf, flen, _w, _h);
    DirkSimple_free(fbuf);
    return (uint8_t *) pixels;
}


// !!! FIXME: we should probably cache all sprites and waves we see in the
// !!! FIXME: game's dir during DirkSimple_startup. There are only a handful
// !!! FIXME: of them, we might as well just load them all upfront instead of
// !!! FIXME: risking a stall on the first use.

static DirkSimple_Sprite *get_cached_sprite(const char *name)
{
    DirkSimple_Sprite *sprite = NULL;

    // lowercase the name, just in case.
    char *loweredname = DirkSimple_xstrdup(name);
    int i;
    for (i = 0; name[i]; i++) {
        char ch = name[i];
        if ((ch >= 'A') && (ch <= 'Z')) {
            loweredname[i] = ch - ('A' - 'a');
        }
    }
    name = loweredname;

    for (sprite = GSprites; sprite != NULL; sprite = sprite->next) {
        if (strcmp(sprite->name, loweredname) == 0) {
            DirkSimple_free(loweredname);
            return sprite;  // already cached.
        }
    }

    // not cached yet, load it from disk.
    const size_t slen = strlen(GGameDir) + strlen(name) + 8;
    char *fname = (char *) DirkSimple_xmalloc(slen);
    snprintf(fname, slen, "%s%s.bmp", GGameDir, name);

    int w, h;
    uint8_t *rgba = DirkSimple_loadbmp(fname, &w, &h);
    if (rgba) {
        DirkSimple_log("Loaded sprite '%s': %dx%d, RGBA", fname, w, h);
    }

    DirkSimple_free(fname);

    if (!rgba) {
        char errmsg[128];
        snprintf(errmsg, sizeof (errmsg), "Failed to load needed sprite '%s'. Check your installation?", name);
        DirkSimple_panic(errmsg);
    }

    sprite = (DirkSimple_Sprite *) DirkSimple_xmalloc(sizeof (DirkSimple_Sprite));
    sprite->name = loweredname;
    sprite->width = w;
    sprite->height = h;
    sprite->rgba = rgba;
    sprite->platform_handle = NULL;
    sprite->next = GSprites;

    GSprites = sprite;

    return sprite;
}

/* this is an extremely simple, low-quality converter, because presumably we're dealing with simple, low-quality audio. */
static float *convertwav(const char *fname, float *pcm, int *_frames, int havechannels, int havefreq, int wantchannels, int wantfreq)
{
    const int frames = *_frames;
    float *dst;
    float *src;
    float *retval = NULL;
    float *rechanneled = NULL;

    DirkSimple_log("Convert audio from '%s': %d frames, %d channels, %dHz -> %d channels, %dHz", fname, frames, havechannels, havefreq, wantchannels, wantfreq);

    if (havechannels == wantchannels) {
        rechanneled = pcm;
    } else {
        dst = rechanneled = (float *) DirkSimple_xmalloc(sizeof (float) * frames * wantchannels);
        src = pcm;
        if ((havechannels == 1) && (wantchannels == 2)) {
            for (int i = 0; i < frames; i++, dst += 2) {
                dst[0] = dst[1] = src[i];
            }
        } else if ((havechannels == 2) && (wantchannels == 1)) {
            for (int i = 0; i < frames; i++, src += 2) {
                *(dst++) = (src[0] + src[1]) * 0.5f;
            }
        } else {
            DirkSimple_free(rechanneled);
            return (float *) invalid_media(fname, "Unsupported audio channel count");
        }
    }

    if (havefreq == wantfreq) {
        retval = rechanneled;
    } else {
        const float scale = ((float) havefreq) / ((float) wantfreq);
        const int newframes = (int) (((float) frames) * (1.0f / scale));
        dst = retval = (float *) DirkSimple_xmalloc(sizeof (float) * newframes * wantchannels);
        src = rechanneled;

        if (wantchannels == 1) {
            float prev = src[0];
            for (int i = 0; i < newframes; i++) {
                const int newframe = (int) (((float) i) * scale);
                const float newval = src[newframe];
                *(dst++) = (prev + newval) * 0.5f;
                prev = newval;
            }
        } else if (wantchannels == 2) {
            float prevl = src[0];
            float prevr = src[1];
            for (int i = 0; i < newframes; i++) {
                const int newframe = ((int) (((float) i) * scale)) * 2;
                const float newl = src[newframe];
                const float newr = src[newframe+1];
                *(dst++) = (prevl + newl) * 0.5f;
                *(dst++) = (prevr + newr) * 0.5f;
                prevl = newl;
                prevr = newr;
            }
        } else {
            if (rechanneled != pcm) {
                DirkSimple_free(rechanneled);
            }
            DirkSimple_free(retval);
            return (float *) invalid_media(fname, "Unsupported audio channel count");
        }

        if (rechanneled != pcm) {
            DirkSimple_free(rechanneled);
        }

        *_frames = newframes;
    }

    return retval;
}

static float *loadwav_from_memory(const char *fname, const uint8_t *buf, int buflen, int *_frames, int *_channels, int *_freq)
{
    const uint8_t *ptr = buf;

    if (buflen < 50) {
        return (float *) invalid_media(fname, "Not a .WAV file");
    }

    if ((ptr[0] != 'R') || (ptr[1] != 'I') || (ptr[2] != 'F') || (ptr[3] != 'F')) {
        return (float *) invalid_media(fname, "Not a .WAV file");
    }

    ptr += 8;  // skip RIFF and size of file in bytes

    if ((ptr[0] != 'W') || (ptr[1] != 'A') || (ptr[2] != 'V') || (ptr[3] != 'E')) {
        return (float *) invalid_media(fname, "Not a .WAV file");
    }
    ptr += 4;

    if ((ptr[0] != 'f') || (ptr[1] != 'm') || (ptr[2] != 't') || (ptr[3] != ' ')) {
        return (float *) invalid_media(fname, "Didn't get expected 'fmt ' tag");
    }
    ptr += 4;

    const uint32_t fmtlen = readui32le(&ptr);
    const uint16_t fmttype = readui16le(&ptr);
    const uint16_t chans = readui16le(&ptr);
    const uint32_t samplerate = readui32le(&ptr);

    if (fmtlen != 16) {  /* Just handling an exact format for simplicity. */
        return (float *) invalid_media(fname, "Unexpected .WAV fmt chunk length");
    } else if (fmttype != 3) {  /* must be float32 encoded for simplicity. */
        return (float *) invalid_media(fname, "Only float32 PCM .WAV files supported");
    } else if ((chans != 1) && (chans != 2)) {
        return (float *) invalid_media(fname, "Only stereo and mono .WAV files supported");
    }

    ptr += 8;  // don't care about the next two fields.

    // skip until we find the data chunk and assume everything else is unnecessary.  :O
    uint32_t datalen;
    while ((ptr[0] != 'd') || (ptr[1] != 'a') || (ptr[2] != 't') || (ptr[3] != 'a')) {
        //DirkSimple_log("CHUNK %c%c%c%c", (char) ptr[0], (char) ptr[1], (char) ptr[2], (char) ptr[3]);
        ptr += 4;
        datalen = readui32le(&ptr);
        //DirkSimple_log("CHUNKLEN %d", (int) datalen);
        if (datalen > (buflen - ((ptr - buf)))) {
            return (float *) invalid_media(fname, "Unexpected .WAV data chunk length");
        }
        ptr += datalen;
    }
    ptr += 4;

    datalen = readui32le(&ptr);
    if (datalen > (buflen - ((ptr - buf)))) {
        return (float *) invalid_media(fname, "Unexpected .WAV data chunk length");
    }

    const int frames = (int) ((datalen / sizeof (float)) / chans);
    datalen = frames * sizeof (float) * chans;  // so this chops off half-frames.
    *_frames = frames;
    *_channels = (int) chans;
    *_freq = (int) samplerate;
    float *pcm = (float *) DirkSimple_xmalloc(datalen);
    memcpy(pcm, ptr, datalen);
    return pcm;
}

float *DirkSimple_loadwav(const char *fname, int *_numframes, const int wantchannels, int wantfreq)
{
    long flen = 0;
    int havechannels = 0;
    int havefreq = 0;
    int frames = 0;
    uint8_t *fbuf = DirkSimple_loadmedia(fname, &flen);
    float *pcm = loadwav_from_memory(fname, fbuf, flen, &frames, &havechannels, &havefreq);
    DirkSimple_free(fbuf);
    if (pcm) {
        float *cvtpcm = convertwav(fname, pcm, &frames, havechannels, havefreq, wantchannels, wantfreq);
        if (cvtpcm != pcm) {
            DirkSimple_free(pcm);
            pcm = cvtpcm;
        }
    }
    *_numframes = frames;
    return pcm;
}

static DirkSimple_Wave *get_cached_wave(const char *name)
{
    DirkSimple_Wave *wave = NULL;
    int frames = 0;

    if (!GAudioChannels || !GAudioFreq) {
        DirkSimple_log("Attempting to use wave '%s' before laserdisc is ready!", name);
        return NULL;
    }

    // lowercase the name, just in case.
    char *loweredname = DirkSimple_xstrdup(name);
    int i;
    for (i = 0; name[i]; i++) {
        char ch = name[i];
        if ((ch >= 'A') && (ch <= 'Z')) {
            loweredname[i] = ch - ('A' - 'a');
        }
    }
    name = loweredname;

    for (wave = GWaves; wave != NULL; wave = wave->next) {
        if (strcmp(wave->name, loweredname) == 0) {
            DirkSimple_free(loweredname);
            return wave;  // already cached.
        }
    }

    // not cached yet, load it from disk.
    const size_t slen = strlen(GGameDir) + strlen(name) + 8;
    char *fname = (char *) DirkSimple_xmalloc(slen);
    snprintf(fname, slen, "%s%s.wav", GGameDir, name);

    float *pcm = DirkSimple_loadwav(fname, &frames, GAudioChannels, GAudioFreq);
    if (pcm) {
        DirkSimple_log("Loaded wave '%s': %d channels, %dHz", fname, GAudioChannels, GAudioFreq);
    }

    DirkSimple_free(fname);

    if (!pcm) {
        char errmsg[128];
        snprintf(errmsg, sizeof (errmsg), "Failed to load needed wave '%s'. Check your installation?", name);
        DirkSimple_panic(errmsg);
    }

    wave = (DirkSimple_Wave *) DirkSimple_xmalloc(sizeof (DirkSimple_Wave));
    wave->name = loweredname;
    wave->numframes = frames;
    wave->pcm = pcm;
    wave->duration_ticks = (uint64_t) ((((float) frames) / ((float) GAudioFreq)) * 1000.0f);
    wave->ticks_when_available = 0;
    wave->platform_handle = NULL;
    wave->next = GWaves;

    GWaves = wave;

    return wave;
}

// Allocator interface for internal Lua use.
static void *DirkSimple_lua_allocator(void *ud, void *ptr, size_t osize, size_t nsize)
{
    if (nsize == 0) {
        DirkSimple_free(ptr);
        return NULL;
    }
    return DirkSimple_xrealloc(ptr, nsize);
}

// Read data from a DirkSimple_Io when loading Lua code.
static const char *DirkSimple_lua_reader(lua_State *L, void *data, size_t *size)
{
    static char buffer[1024];
    DirkSimple_Io *in = (DirkSimple_Io *) data;
    const long br = in->read(in, buffer, sizeof (buffer));
    if (br <= 0) {  // eof or error? (lua doesn't care which?!)
        *size = 0;
        return NULL;
    }

    *size = (size_t) br;
    return buffer;
}

static void collect_lua_garbage(lua_State *L)
{
    lua_gc(L, LUA_GCCOLLECT, 0);
}

static inline int snprintfcat(char **ptr, size_t *len, const char *fmt, ...)
{
    int bw = 0;
    va_list ap;
    va_start(ap, fmt);
    bw = vsnprintf(*ptr, *len, fmt, ap);
    va_end(ap);
    *ptr += bw;
    *len -= bw;
    return bw;
}

static int luahook_DirkSimple_stackwalk(lua_State *L)
{
    const char *errstr = lua_tostring(L, 1);
    lua_Debug ldbg;
    int i;

    if (errstr != NULL) {
        DirkSimple_log(errstr);
    }

    DirkSimple_log("Lua stack backtrace:");

    // start at 1 to skip this function.
    for (i = 1; lua_getstack(L, i, &ldbg); i++) {
        char scratchbuf[256];
        char *ptr = scratchbuf;
        size_t len = sizeof (scratchbuf);
        int bw = snprintfcat(&ptr, &len, "#%d", i-1);
        const int maxspacing = 4;
        int spacing = maxspacing - bw;
        while (spacing-- > 0) {
            snprintfcat(&ptr, &len, " ");
        }

        if (!lua_getinfo(L, "nSl", &ldbg)) {
            snprintfcat(&ptr, &len, "???");
            DirkSimple_log(scratchbuf);
            continue;
        }

        if (ldbg.namewhat[0]) {
            snprintfcat(&ptr, &len, "%s ", ldbg.namewhat);
        }

        if ((ldbg.name) && (ldbg.name[0])) {
            snprintfcat(&ptr, &len, "function %s ()", ldbg.name);
        } else {
            if (strcmp(ldbg.what, "main") == 0) {
                snprintfcat(&ptr, &len, "mainline of chunk");
            } else if (strcmp(ldbg.what, "tail") == 0) {
                snprintfcat(&ptr, &len, "tail call");
            } else {
                snprintfcat(&ptr, &len, "unidentifiable function");
            }
        }

        DirkSimple_log(scratchbuf);
        ptr = scratchbuf;
        len = sizeof (scratchbuf);

        for (spacing = 0; spacing < maxspacing; spacing++) {
            snprintfcat(&ptr, &len, " ");
        }

        if (strcmp(ldbg.what, "C") == 0) {
            snprintfcat(&ptr, &len, "in native code");
        } else if (strcmp(ldbg.what, "tail") == 0) {
            snprintfcat(&ptr, &len, "in Lua code");
        } else if ( (strcmp(ldbg.source, "=?") == 0) && (ldbg.currentline == 0) ) {
            snprintfcat(&ptr, &len, "in Lua code (debug info stripped)");
        } else {
            snprintfcat(&ptr, &len, "in Lua code at %s", ldbg.short_src);
            if (ldbg.currentline != -1)
                snprintfcat(&ptr, &len, ":%d", ldbg.currentline);
        }
        DirkSimple_log(scratchbuf);
    }

    lua_pushstring(L, errstr ? errstr : "");
    return 1;
}

// This just lets you punch in one-liners and Lua will run them as individual
//  chunks, but you can completely access all Lua state, including calling C
//  functions and altering tables. At this time, it's more of a "console"
//  than a debugger. You can do "p DirkSimple_lua_debugger()" from gdb to launch this
//  from a breakpoint in native code, or call DirkSimple.debugger() to launch
//  it from Lua code (with stacktrace intact, too: type 'bt' to see it).
static int luahook_DirkSimple_debugger(lua_State *L)
{
    int origtop;

    lua_pushcfunction(L, luahook_DirkSimple_stackwalk);
    origtop = lua_gettop(L);

    printf("Quick and dirty Lua debugger. Type 'exit' to quit.\n");

    while (1) {
        char buf[256];
        int len = 0;
        printf("> ");
        fflush(stdout);
        if (fgets(buf, sizeof (buf), stdin) == NULL) {
            printf("\n\n  fgets() on stdin failed: ");
            break;
        }

        len = (int) (strlen(buf) - 1);
        while ( (len >= 0) && ((buf[len] == '\n') || (buf[len] == '\r')) ) {
            buf[len--] = '\0';
        }

        if (strcmp(buf, "q") == 0) {
            break;
        } else if (strcmp(buf, "quit") == 0) {
            break;
        } else if (strcmp(buf, "exit") == 0) {
            break;
        } else if (strcmp(buf, "bt") == 0) {
            strcpy(buf, "DirkSimple.stackwalk()");
        }

        if ( (luaL_loadstring(L, buf) != 0) ||
             (lua_pcall(L, 0, LUA_MULTRET, -2) != 0) ) {
            printf("%s\n", lua_tostring(L, -1));
            lua_pop(L, 1);
        } else {
            printf("Returned %d values.\n", lua_gettop(L) - origtop);
            while (lua_gettop(L) != origtop) {
                // !!! FIXME: dump details of values to stdout here.
                lua_pop(L, 1);
            }
            printf("\n");
        }
    }

    lua_pop(L, 1);
    printf("exiting debugger...\n");

    return 0;
}


void DirkSimple_debugger(void)
{
    luahook_DirkSimple_debugger(GLua);
}

static void DirkSimple_halt_video(void)
{
    if (GDecoder) {
        DirkSimple_log("HALT VIDEO: GTicks %u", (unsigned int) GTicks);
        GClipStartMs = 0;
        GClipStartTicks = GTicks;
        GHalted = 1;
        GShowingSingleFrame = 0;
        GSeekGeneration--;  // this just makes it throw away _anything_ until the next seek.
        DirkSimple_cleardiscaudio();
        DirkSimple_discvideo(GBlankVideoFrame);
    }
}

static int luahook_DirkSimple_halt_video(lua_State *L)
{
    DirkSimple_halt_video();
    return 0;
}

static void DirkSimple_show_single_frame(uint32_t startms)
{
    if (GDecoder) {
        DirkSimple_log("START SINGLE FRAME: GTicks %u, startms %u", (unsigned int) GTicks, (unsigned int) startms);
        GSeekGeneration = THEORAPLAY_seek(GDecoder, startms);
        DirkSimple_cleardiscaudio();
        GClipStartMs = startms;
        GClipStartTicks = 0;
        GHalted = 0;
        GShowingSingleFrame = 1;
    }
}

static int luahook_DirkSimple_show_single_frame(lua_State *L)
{
    const uint32_t startms = (uint32_t) lua_tonumber(L, 1);
    DirkSimple_show_single_frame(startms);
    return 0;
}


static void DirkSimple_start_clip(uint32_t startms)
{
    if (GDecoder) {
        DirkSimple_log("START CLIP: GTicks %u, startms %u\n", (unsigned int) GTicks, (unsigned int) startms);
        GSeekGeneration = THEORAPLAY_seek(GDecoder, startms);
        DirkSimple_cleardiscaudio();
        GClipStartMs = startms;
        GClipStartTicks = 0;
        GHalted = 0;
        GShowingSingleFrame = 0;
    }
}

static int luahook_DirkSimple_start_clip(lua_State *L)
{
    const uint32_t startms = (uint32_t) lua_tonumber(L, 1);
    DirkSimple_start_clip(startms);
    return 0;
}

static int luahook_DirkSimple_truncate(lua_State *L)
{
    lua_pushinteger(L, (lua_Integer) lua_tonumber(L, 1));
    return 1;
}

static int luahook_DirkSimple_to_int(lua_State *L)
{
    if (lua_isstring(L, 1)) {
        lua_pushinteger(L, atoi(lua_tostring(L, 1)));
    } else if (lua_isboolean(L, 1)) {
        lua_pushinteger(L, lua_toboolean(L, 1) ? 1 : 0);
    } else if (lua_isnumber(L, 1)) {
        lua_pushinteger(L, (lua_Integer) lua_tonumber(L, 1));
    } else {
        lua_pushinteger(L, 0);
    }
    return 1;
}

static int luahook_DirkSimple_to_bool(lua_State *L)
{
    if (lua_isstring(L, 1)) {
        lua_pushboolean(L, (strcmp(lua_tostring(L, 1), "true") == 0));
    } else if (lua_isboolean(L, 1)) {
        lua_pushboolean(L, lua_toboolean(L, 1));
    } else if (lua_isnumber(L, 1)) {
        lua_pushboolean(L, (lua_tonumber(L, 1) != 0));
    } else {
        lua_pushboolean(L, 0);
    }
    return 1;
}

static void register_lua_libs(lua_State *L)
{
    // We always need the string and base libraries (although base has a
    //  few we could trim). The rest you can compile in if you want/need them.
    int i;
    static const luaL_Reg lualibs[] = {
        {"_G", luaopen_base},
        {LUA_STRLIBNAME, luaopen_string},
        {LUA_TABLIBNAME, luaopen_table},
        //{LUA_LOADLIBNAME, luaopen_package},
        //{LUA_IOLIBNAME, luaopen_io},
        //{LUA_OSLIBNAME, luaopen_os},
        //{LUA_MATHLIBNAME, luaopen_math},
        //{LUA_DBLIBNAME, luaopen_debug},
        //{LUA_BITLIBNAME, luaopen_bit32},
        //{LUA_COLIBNAME, luaopen_coroutine},
    };

    for (i = 0; i < (sizeof (lualibs) / sizeof (lualibs[0])); i++) {
        luaL_requiref(L, lualibs[i].name, lualibs[i].func, 1);
        lua_pop(L, 1);  // remove lib
    }
}

static int luahook_panic(lua_State *L)
{
    const char *errstr;

    luahook_DirkSimple_stackwalk(L);

    errstr = lua_tostring(L, -1);
    if (errstr == NULL) {
        errstr = "Something disastrous happened, aborting.";  // doesn't actually return.
    }

    DirkSimple_panic(errstr);
    return 1;  // doesn't actually return, but stackwalk pushed a return value, so return 1 for hygiene purposes.
}

static int luahook_DirkSimple_log(lua_State *L)
{
    const char *str = lua_tostring(L, 1);
    DirkSimple_log("%s", str);
    return 0;
}

static RenderCommand *new_render_command(const RenderPrimitive prim)
{
    if (GNumRenderCommands >= GNumAllocatedRenderCommands) {
        if (GNumAllocatedRenderCommands == 0) {
            GNumAllocatedRenderCommands = 32;
        } else {
            GNumAllocatedRenderCommands *= 2;
        }
        GRenderCommands = DirkSimple_xrealloc(GRenderCommands, sizeof (RenderCommand) * GNumAllocatedRenderCommands);
    }

    RenderCommand *retval = &GRenderCommands[GNumRenderCommands++];
    retval->prim = prim;
    return retval;
}

static int luahook_DirkSimple_clear_screen(lua_State *L)
{
    RenderCommand *cmd = new_render_command(RENDPRIM_CLEAR);
    cmd->data.clear.r = (uint8_t) lua_tonumber(L, 1);
    cmd->data.clear.g = (uint8_t) lua_tonumber(L, 2);
    cmd->data.clear.b = (uint8_t) lua_tonumber(L, 3);
    return 0;
}

static int luahook_DirkSimple_draw_sprite(lua_State *L)
{
    RenderCommand *cmd = new_render_command(RENDPRIM_SPRITE);
    snprintf(cmd->data.sprite.name, sizeof (cmd->data.sprite.name), "%s", lua_tostring(L, 1));
    cmd->data.sprite.sx = (int32_t) lua_tonumber(L, 2);
    cmd->data.sprite.sy = (int32_t) lua_tonumber(L, 3);
    cmd->data.sprite.sw = (int32_t) lua_tonumber(L, 4);
    cmd->data.sprite.sh = (int32_t) lua_tonumber(L, 5);
    cmd->data.sprite.dx = (int32_t) lua_tonumber(L, 6);
    cmd->data.sprite.dy = (int32_t) lua_tonumber(L, 7);
    cmd->data.sprite.dw = (int32_t) lua_tonumber(L, 8);
    cmd->data.sprite.dh = (int32_t) lua_tonumber(L, 9);
    cmd->data.sprite.r = (uint8_t) lua_tonumber(L, 10);
    cmd->data.sprite.g = (uint8_t) lua_tonumber(L, 11);
    cmd->data.sprite.b = (uint8_t) lua_tonumber(L, 12);
    return 0;
}

static int luahook_DirkSimple_play_sound(lua_State *L)
{
    RenderCommand *cmd = new_render_command(RENDPRIM_SOUND);
    snprintf(cmd->data.sound.name, sizeof (cmd->data.sound.name), "%s", lua_tostring(L, 1));
    return 0;
}

static void load_lua_gamecode(lua_State *L, const char *gamedir)
{
    int rc;
    DirkSimple_Io *io;
    const size_t slen = strlen(gamedir) + 32;
    char *fname = (char *) DirkSimple_xmalloc(slen);
    snprintf(fname, slen, "@%sgame.luac", gamedir);
    io = DirkSimple_openfile_read(fname + 1);
    if (!io) {
        snprintf(fname, slen, "@%sgame.lua", gamedir);
        io = DirkSimple_openfile_read(fname + 1);
        if (!io) {
            char *err = (char *) DirkSimple_xmalloc(slen * 2);
            snprintf(err, slen * 2, "Failed to open Lua code at '%s'", fname + 1);
            DirkSimple_panic(err);
        }
    }

    lua_pushcfunction(L, luahook_DirkSimple_stackwalk);
    rc = lua_load(L, DirkSimple_lua_reader, io, fname, NULL);
    io->close(io);

    DirkSimple_free(fname);

    if (rc != 0) {
        lua_error(L);
    } else {
        // Call new chunk on top of the stack (lua_pcall will pop it off).
        if (lua_pcall(L, 0, 0, -2) != 0) {  // retvals are dumped.
            lua_error(L);   // error on stack has debug info.
        }
        // if this didn't panic, we succeeded.
    }
    lua_pop(L, 1);   // dump stackwalker.
}

static void do_cvar_registration(const char *name, const char *desc, const char *values)
{
    if (name && desc && values) {
        DirkSimple_log("Registering cvar '%s' (%s), valid values are '%s'", name, desc, values);
        DirkSimple_registercvar(GGameName, name, desc, values);
    }
}

static void register_cvars(lua_State *L)
{
    if (L) {
        lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
        if (lua_istable(L, -1)) {  // namespace is sane?
            lua_getfield(L, -1, "cvars");
            if (lua_istable(L, -1)) {  // if not a table, maybe unsupported by this game
                lua_pushnil(L);  // first key for iteration...
                while (lua_next(L, -2)) { // replaces key, pushes value.
                    if (lua_istable(L, -1)) {
                        const char *cvar_name = NULL;
                        const char *cvar_desc = NULL;
                        const char *cvar_values = NULL;
                        lua_getfield(L, -1, "name");
                        cvar_name = lua_tostring(L, -1);
                        lua_getfield(L, -2, "desc");
                        cvar_desc = lua_tostring(L, -1);
                        lua_getfield(L, -3, "values");
                        cvar_values = lua_tostring(L, -1);
                        do_cvar_registration(cvar_name, cvar_desc, cvar_values);
                        lua_pop(L, 3);  // dump name, desc, values
                    }
                    lua_pop(L, 1);  // remove table, keep key for next iteration.
                }
            }
            lua_pop(L, 1);  // pop the cvars table
        }
        lua_pop(L, 1);  // pop the namespace
    }

    // !!! FIXME: register engine-level cvars here.
}

// setter lua function is on top of the Lua stack. This function will pop it.
static void set_lua_cvar(lua_State *L, const char *name, const char *valid_values, const char *newvalue)
{
    const size_t slenvalid = strlen(valid_values);
    const size_t slennew = strlen(newvalue);
    const char *ptr;

    if (slenvalid < slennew) {
        lua_pop(L, 1);  // pop the setter
        return;  // newvalue can't be listed in valid_values, it's bigger than the valid list string.
    }

    ptr = strstr(valid_values, newvalue);
    if (!ptr) {
        lua_pop(L, 1);  // pop the setter
        return;  // not listed in valid_values
    }

    if ( (slenvalid == slennew) ||  // matches entire string
         ((ptr == valid_values) && (valid_values[slennew] == '|')) ||   // matches start of string
         ((ptr > valid_values) && (ptr[-1] == '|') && ((ptr[slennew] == '|') || (ptr[slennew] == '\0'))) ) {  // matches middle or end of string
        // it's valid, pass it to Lua.
        lua_pushstring(L, name);
        lua_pushstring(L, newvalue);
        lua_call(L, 2, 0);
    }
}

void DirkSimple_setcvar(const char *name, const char *newvalue)
{
    lua_State *L = GLua;
    if (L) {
        lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
        if (lua_istable(L, -1)) {  // namespace is sane?
            lua_getfield(L, -1, "cvars");
            if (lua_istable(L, -1)) {  // if not a table, maybe unsupported by this game
                lua_pushnil(L);  // first key for iteration...
                while (lua_next(L, -2)) { // replaces key, pushes value.
                    int endloop = 0;
                    if (lua_istable(L, -1)) {
                        const char *cvarname;
                        lua_getfield(L, -1, "name");
                        cvarname = lua_tostring(L, -1);
                        if (cvarname && (strcmp(cvarname, name) == 0)) {
                            const char *values;
                            lua_getfield(L, -2, "values");
                            values = lua_tostring(L, -1);
                            if (values) {
                                lua_getfield(L, -3, "setter");
                                if (lua_isfunction(L, -1)) {
                                    set_lua_cvar(L, name, values, newvalue);
                                } else {
                                    lua_pop(L, 1);  // pop the setter
                                }
                                endloop = 1;  // we're done.
                            }
                            lua_pop(L, 1);  // pop the values
                        }
                        lua_pop(L, 1);  // pop the name
                    }
                    lua_pop(L, 1);  // pop the table, keep key for next iteration.

                    if (endloop) {
                        lua_pop(L, 1);  // dump key, too.
                        break;
                    }
                }
            }
            lua_pop(L, 1);  // pop the cvars table
        }
        lua_pop(L, 1);  // pop the namespace
    }
}

// Sets t[sym]=f, where t is on the top of the Lua stack.
static void set_cfunc(lua_State *L, lua_CFunction f, const char *sym)
{
    lua_pushcfunction(L, f);
    lua_setfield(L, -2, sym);
}

// Sets t[sym]=f, where t is on the top of the Lua stack.
static void set_integer(lua_State *L, const int x, const char *sym)
{
    lua_pushinteger(L, x);
    lua_setfield(L, -2, sym);
}

// Sets t[sym]=f, where t is on the top of the Lua stack.
static void set_string(lua_State *L, const char *str, const char *sym)
{
    lua_pushstring(L, str);
    lua_setfield(L, -2, sym);
}

static void setup_lua(void)
{
    GLua = lua_newstate(DirkSimple_lua_allocator, NULL);  // calls DirkSimple_panic() on failure.
    lua_atpanic(GLua, luahook_panic);
    register_lua_libs(GLua);

    // Build DirkSimple namespace for Lua to access and fill in C bridges...
    lua_newtable(GLua);
        set_cfunc(GLua, luahook_DirkSimple_show_single_frame, "show_single_frame");
        set_cfunc(GLua, luahook_DirkSimple_start_clip, "start_clip");
        set_cfunc(GLua, luahook_DirkSimple_halt_video, "halt_video");
        set_cfunc(GLua, luahook_DirkSimple_log, "log");
        set_cfunc(GLua, luahook_panic, "panic");
        set_cfunc(GLua, luahook_DirkSimple_stackwalk, "stackwalk");
        set_cfunc(GLua, luahook_DirkSimple_debugger, "debugger");
        set_cfunc(GLua, luahook_DirkSimple_truncate, "truncate");
        set_cfunc(GLua, luahook_DirkSimple_to_int, "to_int");
        set_cfunc(GLua, luahook_DirkSimple_to_bool, "to_bool");
        set_cfunc(GLua, luahook_DirkSimple_clear_screen, "clear_screen");
        set_cfunc(GLua, luahook_DirkSimple_draw_sprite, "draw_sprite");
        set_cfunc(GLua, luahook_DirkSimple_play_sound, "play_sound");
        set_string(GLua, "", "gametitle");
        set_string(GLua, GLuaLicense, "lua_license");  // just so deadcode elimination can't remove this string from the binary.
    lua_setglobal(GLua, DIRKSIMPLE_LUA_NAMESPACE);

    load_lua_gamecode(GLua, GGameDir);

    register_cvars(GLua);

    collect_lua_garbage(GLua);  // get rid of old init crap we don't need.
}

static void setup_game_strings(const char *basedir, const char *gamepath, const char *gamename)
{
    char *ptr;
    size_t slen;

    GGamePath = DirkSimple_xstrdup(gamepath);

    if (gamename) {
        GGameName = DirkSimple_xstrdup(gamename);
    } else {
        // Find the filename, without parent directories, to figure out the game name.
        for (ptr = GGamePath + strlen(GGamePath); ptr >= GGamePath; ptr--) {
            #if defined(_WIN32) || defined(__OS2__)
            if (*ptr == '\\') {
                ptr++;
                break;
            }
            #endif

            if (*ptr == '/') {
                ptr++;
                break;
            }
        }

        if (ptr < GGamePath) {
            ptr = GGamePath;
        }

        GGameName = DirkSimple_xstrdup(ptr);

        // dump the filename extension.
        for (ptr = GGameName + strlen(GGameName); ptr >= GGameName; ptr--) {
            if (*ptr == '.') {
                *ptr = '\0';
                break;
            }
        }
    }

    // lowercase what's left, just in case.
    for (ptr = GGameName; *ptr; ptr++) {
        const char ch = *ptr;
        if ((ch >= 'A') && (ch <= 'Z')) {
            *ptr = ch - ('A' - 'a');
        }
    }

    slen = strlen(basedir) + 32;
    GDataDir = (char *) DirkSimple_xmalloc(slen);
    snprintf(GDataDir, slen, "%sdata%s", basedir, DIRSEP);

    slen = strlen(GDataDir) + strlen(GGameName) + 32;
    GGameDir = (char *) DirkSimple_xmalloc(slen);
    snprintf(GGameDir, slen, "%sgames%s%s%s", GDataDir, DIRSEP, GGameName, DIRSEP);
}

static void *DirkSimple_theoraplay_allocate(const THEORAPLAY_Allocator *allocator, unsigned int len) { return DirkSimple_xmalloc((size_t) len); }
static void DirkSimple_theoraplay_deallocate(const THEORAPLAY_Allocator *allocator, void *ptr) { DirkSimple_free(ptr); }

static void setup_movie(const char *gamepath, DirkSimple_PixFmt pixfmt)
{
    THEORAPLAY_Allocator allocator;

    allocator.allocate = DirkSimple_theoraplay_allocate;
    allocator.deallocate = DirkSimple_theoraplay_deallocate;
    allocator.userdata = NULL;

    DirkSimple_Io *io = DirkSimple_openfile_read(gamepath);
    if (!io) {
        const size_t slen = strlen(gamepath) + 5;
        char *gamepath_ext = DirkSimple_xmalloc(slen);
        if (gamepath_ext) {
            snprintf(gamepath_ext, slen, "%s.ogv", gamepath);
            io = DirkSimple_openfile_read(gamepath_ext);
            DirkSimple_free(gamepath_ext);
        }
        if (!io) {
            DirkSimple_panic("Couldn't open game path!");
        }
    }

    GTheoraplayIo.read = theoraplayiobridge_read;
    GTheoraplayIo.streamlen = theoraplayiobridge_streamlen;
    GTheoraplayIo.seek = theoraplayiobridge_seek;
    GTheoraplayIo.close = theoraplayiobridge_close;
    GTheoraplayIo.userdata = io;
    GDecoder = THEORAPLAY_startDecode(&GTheoraplayIo, 30, (THEORAPLAY_VideoFormat) pixfmt, &allocator, DIRKSIMPLE_MULTITHREADED);
    if (!GDecoder) {
        DirkSimple_panic("Failed to start movie decoding!");
    }
}

void DirkSimple_startup(const char *basedir, const char *gamepath, const char *gamename, DirkSimple_PixFmt pixfmt)
{
    DirkSimple_shutdown();  // safe to call even if not started up at the moment.

    setup_game_strings(basedir, gamepath, gamename);
    setup_lua();
    setup_movie(GGamePath, pixfmt);
}

void DirkSimple_restart(void)  // DO NOT CALL THIS FROM LUA CODE
{
    if (GLua) {
        lua_close(GLua);
        GLua = NULL;
    }
    setup_lua();
}

static size_t serialize_lua_array(lua_State *L, void *_data, size_t len)
{
    uint8_t *data = (uint8_t *) _data;
    size_t bw = 0;
    lua_Integer i, total;

    lua_len(L, -1);
    total = lua_tointeger(L, -1);
    lua_pop(L, 1);
    for (i = 1; i <= total; i++) {
        const int luatype = lua_geti(L, -1, i);
        if (bw < len) {
            *(data++) = (uint8_t) luatype;
        }
        bw++;

        switch (luatype) {
            case LUA_TBOOLEAN:
                if (bw < len) {
                    *(data++) = lua_toboolean(L, -1) ? 1 : 0;
                }
                bw++;
                break;
            case LUA_TNUMBER:
                if ((bw+4) <= len) {
                    union { float f; uint32_t u32; uint8_t u8[4]; } cvt;
                    cvt.f = (float) lua_tonumber(L, -1);
                    cvt.u32 = (((uint32_t) cvt.u8[0]) << 24) | (((uint32_t) cvt.u8[1]) << 16) | (((uint32_t) cvt.u8[2]) << 8) | (((uint32_t) cvt.u8[3]) << 0);
                    *(data++) = cvt.u8[0];
                    *(data++) = cvt.u8[1];
                    *(data++) = cvt.u8[2];
                    *(data++) = cvt.u8[3];
                }
                bw += 4;
                break;
            case LUA_TSTRING:
                if ((bw+32) <= len) {
                    size_t i;
                    size_t slen = 0;
                    const char *str = lua_tolstring (L, -1, &slen);
                    if (slen > 31) {
                        DirkSimple_panic("Tried to serialized too-long string. This is a DirkSimple bug!");
                    }
                    *(data++) = (uint8_t) slen;
                    for (i = 0; i < slen; i++) {
                        *(data++) = str[i];
                    }
                    while (i < 31) {
                        *(data++) = '\0';
                        i++;
                    }
                }
                bw += 32;  // retroarch needs the size to be consistent, so we pack all strings to 32 bytes.
                break;
            default:
                DirkSimple_panic("Tried to serialized unsupported data type. This is a DirkSimple bug!");
                break;
        }
        lua_pop(L, 1);  // drop the aray element.
    }

    return bw;
}

static int unserialize_lua_array(lua_State *L, const void *_data, size_t len)
{
    const uint8_t *data = (const uint8_t *) _data;
    lua_Integer idx = 0;

    lua_newtable(L);  // the Lua array we'll decode into.

    while (len > 0) {
        const int luatype = (int) *(data++);
        len--;

        switch (luatype) {
            case LUA_TBOOLEAN:
                if (len < 1) {
                    lua_pop(L, 1);  // dump the table
                    return 0;
                }
                lua_pushboolean(L, *(data++) ? 1 : 0);
                len--;
                break;

            case LUA_TNUMBER:
                if (len < 4) {
                    lua_pop(L, 1);  // dump the table
                    return 0;
                } else {
                    union { float f; uint32_t u32; uint8_t u8[4]; } cvt;
                    cvt.u8[0] = *(data++);
                    cvt.u8[1] = *(data++);
                    cvt.u8[2] = *(data++);
                    cvt.u8[3] = *(data++);
                    cvt.u32 = (((uint32_t) cvt.u8[0]) << 24) | (((uint32_t) cvt.u8[1]) << 16) | (((uint32_t) cvt.u8[2]) << 8) | (((uint32_t) cvt.u8[3]) << 0);
                    lua_pushnumber(L, (lua_Number) cvt.f);
                }
                len -= 4;
                break;

            case LUA_TSTRING:
                if (len < 32) {
                    lua_pop(L, 1);  // dump the table
                    return 0;
                } else {
                    const uint8_t chars = *(data++);
                    if (chars > 31) {
                        lua_pop(L, 1);  // dump the table
                        return 0;
                    } else {
                        lua_pushlstring(L, (const char *) data, chars);
                    }
                }
                data += 31;
                len -= 32;
                break;

            default:   // unsupported data type or corrupt data, dump it.
                lua_pop(L, 1);  // dump the table
                return 0;
        }
        lua_seti(L, -2, ++idx);
    }

    return 1;
}

size_t DirkSimple_serialize(void *data, size_t len)
{
    lua_State *L = GLua;
    size_t retval = 0;
    if (L) {
        lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
        if (lua_istable(L, -1)) {  // namespace is sane?
            lua_getfield(L, -1, "serialize");
            if (lua_isfunction(L, -1)) {  // if not function, maybe unsupported by this game
                lua_call(L, 0, 1);    // top of the stack is the return value.
                if (lua_istable(L, -1)) {
                    retval = serialize_lua_array(L, data, len);
                }
                lua_pop(L, 1);  // pop the return value.
            }
        }
        lua_pop(L, 1);  // pop the namespace
    }
    return retval;
}

int DirkSimple_unserialize(const void *data, size_t len)
{
    lua_State *L = GLua;
    int retval = 0;
    if (L) {
        lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
        if (lua_istable(L, -1)) {  // namespace is sane?
            lua_getfield(L, -1, "unserialize");
            if (lua_isfunction(L, -1)) {  // if not function, maybe unsupported by this game
                if (unserialize_lua_array(L, data, len)) {  // this will push the array on top of the function as an argument.
                    lua_call(L, 1, 1);  // this will pop the array argument and function.
                    retval = lua_toboolean(L, -1) ? 1 : 0;
                }
                lua_pop(L, 1);  // pop the return value (or the function we never called).
            }
        }
        lua_pop(L, 1);  // pop the namespace
    }
    return retval;
}

void DirkSimple_shutdown(void)
{
    DirkSimple_Sprite *sprite;
    DirkSimple_Sprite *spritenext;
    for (sprite = GSprites; sprite != NULL; sprite = spritenext) {
        spritenext = sprite->next;
        DirkSimple_destroysprite(sprite);
        DirkSimple_free(sprite->name);
        DirkSimple_free(sprite->rgba);
        DirkSimple_free(sprite);
    }
    GSprites = NULL;

    DirkSimple_Wave *wave;
    DirkSimple_Wave *wavenext;
    for (wave = GWaves; wave != NULL; wave = wavenext) {
        wavenext = wave->next;
        DirkSimple_destroywave(wave);
        DirkSimple_free(wave->name);
        DirkSimple_free(wave->pcm);
        DirkSimple_free(wave);
    }
    GWaves = NULL;

    DirkSimple_free(GRenderCommands);
    GRenderCommands = NULL;
    GNumRenderCommands = 0;
    GNumAllocatedRenderCommands = 0;

    THEORAPLAY_stopDecode(GDecoder);
    GDecoder = NULL;
    GFrameMS = 0;
    GTicks = 0;
    GTicksOffset = 0;
    GSeekToTicksOffset = 0;
    GClipStartMs = 0xFFFFFFFF;
    GHalted = 0;
    GShowingSingleFrame = 0;
    GClipStartTicks = 0;
    GSeekGeneration = 0;
    GNeedInitialLuaTick = 1;
    GPreviousInputBits = 0;
    GDiscoveredVideoFormat = 0;
    GDiscoveredAudioFormat = 0;
    GAudioChannels = 0;
    GAudioFreq = 0;
    GPendingVideoFrame = NULL;
    DirkSimple_free(GBlankVideoFrame);
    GBlankVideoFrame = NULL;
    DirkSimple_free(GGameName);
    GGameName = NULL;
    DirkSimple_free(GGamePath);
    GGamePath = NULL;
    DirkSimple_free(GGameDir);
    GGameDir = NULL;
    DirkSimple_free(GDataDir);
    GDataDir = NULL;
    if (GLua) {
        lua_close(GLua);
        GLua = NULL;
    }
}


// Sets t[sym]=f, where t is on the top of the Lua stack.
static void set_boolean(lua_State *L, int x, const char *sym)
{
    lua_pushboolean(L, x);
    lua_setfield(L, -2, sym);
}

typedef int (*inputbit_testfn)(const uint64_t curbits, const uint64_t prevbits, const uint64_t flag);

static int inputbit_is_pressed(const uint64_t curbits, const uint64_t prevbits, const uint64_t flag)
{
    return ((curbits & flag) != 0) && ((prevbits & flag) == 0);
}

static int inputbit_is_held(const uint64_t curbits, const uint64_t prevbits, const uint64_t flag)
{
    return ((curbits & prevbits & flag) != 0);
}

static int inputbit_is_released(const uint64_t curbits, const uint64_t prevbits, const uint64_t flag)
{
    return ((curbits & flag) == 0) && ((prevbits & flag) != 0);
}

static int inputbit_is_untouched(const uint64_t curbits, const uint64_t prevbits, const uint64_t flag)
{
    return ((curbits & prevbits & flag) == 0);
}

static void set_input_subtable(lua_State *L, const char *tablename, inputbit_testfn testfn, uint64_t curbits, uint64_t prevbits)
{
    lua_newtable(L);  // the subtable
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_UP), "up");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_DOWN), "down");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_LEFT), "left");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_RIGHT), "right");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_ACTION1), "action");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_ACTION2), "action2");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_COINSLOT), "coinslot");
        set_boolean(L, testfn(curbits, prevbits, DIRKSIMPLE_INPUT_START), "start");
    lua_setfield(L, -2, tablename);
}

static void push_inputs_table(lua_State *L, const uint64_t curbits)
{
    const uint64_t prevbits = GPreviousInputBits;
    lua_newtable(L);  // the inputs table
    set_input_subtable(L, "pressed", inputbit_is_pressed, curbits, prevbits);
    set_input_subtable(L, "held", inputbit_is_held, curbits, prevbits);
    set_input_subtable(L, "released", inputbit_is_released, curbits, prevbits);
    set_input_subtable(L, "untouched", inputbit_is_untouched, curbits, prevbits);
    // inputs table is ready, on top of Lua stack.
}

static void call_lua_tick(lua_State *L, uint64_t ticks, uint64_t clipstartticks, uint64_t inputbits)
{
    lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
    if (!lua_istable(L, -1)) {  // namespace is sane?
        DirkSimple_panic("DirkSimple Lua namespace is not a table!");
    }
    lua_getfield(L, -1, "tick");
    if (!lua_isfunction(L, -1)) {
        DirkSimple_panic("DirkSimple.tick is not a function!");
    }
    lua_pushnumber(L, (lua_Number) ticks);
    lua_pushnumber(L, (lua_Number) clipstartticks);
    push_inputs_table(L, inputbits);
    lua_call(L, 3, 0);  // this will pop the function and args
    lua_pop(L, 1);  // pop the namespace

    // Clean up any Lua tick waste.
    collect_lua_garbage(L);  // we can move this to start_clip if it turns out to be too heavy.
}

static const char *pixfmtstr(const THEORAPLAY_VideoFormat pixfmt)
{
    switch (pixfmt) {
        #define PIXFMTCASE(x) case THEORAPLAY_VIDFMT_##x: return #x
        PIXFMTCASE(YV12);
        PIXFMTCASE(IYUV);
        PIXFMTCASE(RGB);
        PIXFMTCASE(RGBA);
        PIXFMTCASE(BGRA);
        PIXFMTCASE(RGB565);
        #undef PIXFMTCASE
        default: break;
    }
    return "[unknown]";
}

static void send_rendering_primitives(void)
{
    DirkSimple_beginframe();
    for (int i = 0; i < GNumRenderCommands; i++) {
        const RenderCommand *cmd = &GRenderCommands[i];
        switch (cmd->prim) {
            case RENDPRIM_CLEAR:
                DirkSimple_clearscreen(cmd->data.clear.r, cmd->data.clear.g, cmd->data.clear.b);
                break;
            case RENDPRIM_SPRITE:
                DirkSimple_drawsprite(get_cached_sprite(cmd->data.sprite.name),
                                      cmd->data.sprite.sx, cmd->data.sprite.sy, cmd->data.sprite.sw, cmd->data.sprite.sh,
                                      cmd->data.sprite.dx, cmd->data.sprite.dy, cmd->data.sprite.dw, cmd->data.sprite.dh,
                                      cmd->data.sprite.r, cmd->data.sprite.g, cmd->data.sprite.b);
                break;
            case RENDPRIM_SOUND:
                DirkSimple_playwave(get_cached_wave(cmd->data.sound.name));
                break;
            default:
                DirkSimple_panic("Unexpected rendering primitive");
                break;
        }
    }
    DirkSimple_endframe();

    GNumRenderCommands = 0;
}

static void DirkSimple_tick_impl(uint64_t monotonic_ms, uint64_t inputbits)
{
    lua_State *L = GLua;
    const THEORAPLAY_AudioPacket *audio = NULL;

    if (!L) {
        DirkSimple_panic("Lua VM is missing?!");
    } else if (!GDecoder) {
        DirkSimple_panic("Video decoder is missing?!");
    }

    THEORAPLAY_pumpDecode(GDecoder, 5);

    if (!THEORAPLAY_isInitialized(GDecoder)) {
        return;  // still waiting for the decoder to spin up, don't do anything yet.
    }

    if (!GDiscoveredVideoFormat) {
        const THEORAPLAY_VideoFrame *video;
        const char *gametitle_lua = NULL;
        char *gametitle = NULL;

        if (!THEORAPLAY_hasVideoStream(GDecoder)) {
            DirkSimple_panic("Movie file has no video stream!");
        }
        video = THEORAPLAY_getVideo(GDecoder);
        if (!video) {
            return;  // still waiting on video to arrive so we can figure out format.
        }

        // see if the Lua code told us the proper title for this game.
        if (L != NULL) {
            lua_getglobal(L, DIRKSIMPLE_LUA_NAMESPACE);
            if (lua_istable(L, -1)) {  // namespace is sane?
                lua_getfield(L, -1, "gametitle");
                gametitle_lua = lua_tostring(L, -1);
                if (gametitle_lua) {
                    gametitle = DirkSimple_xstrdup(gametitle_lua);
                }
                lua_pop(L, 1);

                // This is the dimensions of the video, which might not actually match what the arcade used.
                set_integer(L, (int) video->width, "video_width");
                set_integer(L, (int) video->height, "video_height");
            }
            lua_pop(L, 1);
        }

        GFrameMS = (video->fps == 0.0) ? 0 : ((uint32_t) (1000.0 / video->fps));

        GDiscoveredVideoFormat = 1;
        DirkSimple_log("We are playing '%s'", gametitle);
        DirkSimple_log("Virtual laserdisc video format: %s, %dx%d, %ffps", pixfmtstr(video->format), (int) video->width, video->height, video->fps);
        DirkSimple_videoformat(gametitle, video->width, video->height, video->fps);
        DirkSimple_free(gametitle);

        switch (video->format) {
            case THEORAPLAY_VIDFMT_YV12:
            case THEORAPLAY_VIDFMT_IYUV:
                GBlankVideoFrame = DirkSimple_xcalloc(1, (video->width * video->height) + ((video->width * video->height) / 2));
                memset(GBlankVideoFrame + (video->width * video->height), 128, (video->width * video->height) / 2);
                break;

            case THEORAPLAY_VIDFMT_RGB:
                GBlankVideoFrame = DirkSimple_xcalloc(video->width * video->height, 3);
                break;

            case THEORAPLAY_VIDFMT_RGBA:
            case THEORAPLAY_VIDFMT_BGRA:
                GBlankVideoFrame = DirkSimple_xcalloc(video->width * video->height, sizeof (uint32_t));
                break;

            case THEORAPLAY_VIDFMT_RGB565:
                GBlankVideoFrame = DirkSimple_xcalloc(video->width * video->height, sizeof (uint16_t));
                break;
        }

        THEORAPLAY_freeVideo(video);  // dump this, the game is going to seek at startup anyhow.
        DirkSimple_discvideo(GBlankVideoFrame);
    }

    if (!GDiscoveredAudioFormat) {
        if (!THEORAPLAY_hasAudioStream(GDecoder)) {
            DirkSimple_panic("Movie file has no audio stream!");  // maybe this shouldn't be fatal?
        }
        audio = THEORAPLAY_getAudio(GDecoder);
        if (!audio) {
            return;  // still waiting on audio to arrive so we can figure out format.
        }
        GDiscoveredAudioFormat = 1;
        GAudioChannels = audio->channels;
        GAudioFreq = audio->freq;
        DirkSimple_log("Virtual laserdisc audio format: float32, %d channels, %dHz", (int) audio->channels, (int) audio->freq);
        DirkSimple_audioformat(audio->channels, audio->freq);
        THEORAPLAY_freeAudio(audio);  // dump this, the game is going to seek at startup anyhow.
    }

    if (GTicksOffset == 0) {
        if (monotonic_ms < 2) {
            return;  // just let this tick up until subtracting 1 is still > 0.
        }
        GTicksOffset = monotonic_ms - 1;
    } else if (GTicksOffset > monotonic_ms) {
        DirkSimple_panic("Time ran backwards! Aborting!");
    }

    GTicks = monotonic_ms - GTicksOffset;

    //DirkSimple_log("Tick %u\n", (unsigned int) GTicks);

    // Call our Lua tick function if we aren't seeking...
    const unsigned int expected_seek_generation = GSeekGeneration;
    if (GNeedInitialLuaTick) {
        GNeedInitialLuaTick = 0;
        call_lua_tick(L, 0, 0, 0);
    } else if (GClipStartTicks) {
        call_lua_tick(L, GTicks, (GTicks - GClipStartTicks), inputbits);
    }

    if (GHalted) {
        return;  // video playback is halted? We've done the tick, just return now.
    }

    // the tick function demanded a seek, don't bother messing with the movie this frame.
    // also doing this after the tick makes sure we don't render any frames past the end
    // of the scene due to latency and process scheduling.
    if (GSeekGeneration != expected_seek_generation) {
        return;
    }

    if (!GPendingVideoFrame) {
        GPendingVideoFrame = THEORAPLAY_getVideo(GDecoder);
    }

    // Clean out decoded frames from before the latest seek that had already made it into the queue.
    // Also, seeking might drop us back before the start of the clip, because we have to find a key frame,
    // so throw out any frames with timestamps before the current clip's start, too, even if they're in
    // the current seek generation. This also helps it not show video at startup before the game logic has
    // selected a clip to play.
    while (GPendingVideoFrame && ((GPendingVideoFrame->seek_generation != GSeekGeneration) || (GPendingVideoFrame->playms < GClipStartMs))) {
        //if (GPendingVideoFrame->seek_generation != GSeekGeneration) { DirkSimple_log("Dumping video frame from previous seek generation"); }
        //else if (GPendingVideoFrame->playms < GClipStartMs) { DirkSimple_log("Dumping video frame from before clip start time (%u vs %u)", (unsigned int) GPendingVideoFrame->playms, (unsigned int) GClipStartMs); }
        THEORAPLAY_freeVideo(GPendingVideoFrame);
        GPendingVideoFrame = THEORAPLAY_getVideo(GDecoder);
    }

    // has seek completed? Sync us back up.
    if (GPendingVideoFrame && (GClipStartTicks == 0)) {
        GClipStartTicks = GTicks;
        GSeekToTicksOffset = ((int64_t) GTicks) - ((int64_t) GClipStartMs);
        if (GShowingSingleFrame) {
            DirkSimple_discvideo(GPendingVideoFrame->pixels);
            THEORAPLAY_freeVideo(GPendingVideoFrame);
            GPendingVideoFrame = NULL;
        }
        // we didn't call the tick earlier in this function because we were still waiting; do it now that the seek is resolved.
        call_lua_tick(L, GTicks, (GTicks - GClipStartTicks), inputbits);
    }

    if (!GShowingSingleFrame) {
        while ((audio = THEORAPLAY_getAudio(GDecoder)) != NULL) {
            if (audio->seek_generation == GSeekGeneration) {  // frame from before our latest seek, dump it.
                DirkSimple_discaudio(audio->samples, audio->frames);
            }
            THEORAPLAY_freeAudio(audio);
        }

        // Feed the next video frame when it's time.
        if (GPendingVideoFrame) {
            int64_t playms = ((int64_t) GPendingVideoFrame->playms) + GSeekToTicksOffset;
            //DirkSimple_log("Consider frame->playms=%u GTicks=%u offset=%d cvt=%d\n", (unsigned int) GPendingVideoFrame->playms, (unsigned int) GTicks, (int) GSeekToTicksOffset, (int) playms);
            if (playms <= (int64_t) GTicks) {
                //DirkSimple_log("Play video frame (%u ms)!\n", (unsigned int) (video->playms - GSeekToTicksOffset));
                if ( GFrameMS && ((GTicks - playms) >= GFrameMS) ) {
                    // Skip frames to catch up, but keep track of the last one
                    //  in case we catch up to a series of dupe frames, which
                    //  means we'd have to draw that final frame and then wait for
                    //  more.
                    const THEORAPLAY_VideoFrame *last = GPendingVideoFrame;
                    while ((GPendingVideoFrame = THEORAPLAY_getVideo(GDecoder)) != NULL) {
                        THEORAPLAY_freeVideo(last);
                        last = GPendingVideoFrame;
                        playms = ((int64_t) GPendingVideoFrame->playms) + GSeekToTicksOffset;
                        //DirkSimple_log("Catchup frame %u\n", (unsigned int) playms);
                        if ((((int64_t) GTicks) - playms) < ((int64_t) GFrameMS)) {
                            break;
                        }
                    }

                    if (!GPendingVideoFrame) {
                        GPendingVideoFrame = last;
                    }
                }

                if (!GPendingVideoFrame) {  // do nothing; we're far behind and out of options.
                    static uint64_t last_warned = 0;
                    if ((!last_warned) || ((GTicks - last_warned) > 10000)) {
                        last_warned = GTicks;
                        DirkSimple_log("WARNING: Video playback can't keep up!");
                    }
                } else {
                    DirkSimple_discvideo(GPendingVideoFrame->pixels);
                    THEORAPLAY_freeVideo(GPendingVideoFrame);
                    GPendingVideoFrame = NULL;
                }
            }
        }
    }
}

void DirkSimple_tick(uint64_t monotonic_ms, uint64_t inputbits)
{
    DirkSimple_tick_impl(monotonic_ms, inputbits);
    send_rendering_primitives();
    GPreviousInputBits = inputbits;
}

// end of dirksimple.c ...

