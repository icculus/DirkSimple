/**
 * TheoraPlay; multithreaded Ogg Theora/Ogg Vorbis decoding.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#ifndef _INCL_THEORAPLAY_H_
#define _INCL_THEORAPLAY_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct THEORAPLAY_Io THEORAPLAY_Io;
struct THEORAPLAY_Io
{
    long (*read)(THEORAPLAY_Io *io, void *buf, long buflen);
    long (*streamlen)(THEORAPLAY_Io *io);
    int (*seek)(THEORAPLAY_Io *io, long absolute_offset);
    void (*close)(THEORAPLAY_Io *io);
    void *userdata;
};

typedef struct THEORAPLAY_Allocator THEORAPLAY_Allocator;
struct THEORAPLAY_Allocator
{
    void *(*allocate)(const THEORAPLAY_Allocator *allocator, unsigned int len);
    void (*deallocate)(const THEORAPLAY_Allocator *allocator, void *ptr);
    void *userdata;
};


typedef struct THEORAPLAY_Decoder THEORAPLAY_Decoder;

/* YV12 is YCrCb, not YCbCr; that's what SDL uses for YV12 overlays. */
typedef enum THEORAPLAY_VideoFormat
{
    THEORAPLAY_VIDFMT_YV12,  /* NTSC colorspace, planar YCrCb 4:2:0 */
    THEORAPLAY_VIDFMT_IYUV,  /* NTSC colorspace, planar YCbCr 4:2:0 */
    THEORAPLAY_VIDFMT_RGB,   /* 24 bits packed pixel RGB */
    THEORAPLAY_VIDFMT_RGBA,  /* 32 bits packed pixel RGBA (full alpha). */
    THEORAPLAY_VIDFMT_BGRA,  /* 32 bits packed pixel BGRA (full alpha). */
    THEORAPLAY_VIDFMT_RGB565 /* 16 bits packed pixel RGB565. */
} THEORAPLAY_VideoFormat;

typedef struct THEORAPLAY_VideoFrame
{
    unsigned int seek_generation;  /* when seeking, throw away any frames from previous seek generation. */
    unsigned int playms;
    double fps;
    unsigned int width;
    unsigned int height;
    THEORAPLAY_VideoFormat format;
    unsigned char *pixels;
    struct THEORAPLAY_VideoFrame *next;
} THEORAPLAY_VideoFrame;

typedef struct THEORAPLAY_AudioPacket
{
    unsigned int seek_generation;  /* when seeking, throw away any frames from previous seek generation. */
    unsigned int playms;  /* playback start time in milliseconds. */
    int channels;
    int freq;
    int frames;
    float *samples;  /* frames * channels float32 samples. */
    struct THEORAPLAY_AudioPacket *next;
} THEORAPLAY_AudioPacket;

THEORAPLAY_Decoder *THEORAPLAY_startDecodeFile(const char *fname,
                                               const unsigned int maxframes,
                                               THEORAPLAY_VideoFormat vidfmt,
                                               const THEORAPLAY_Allocator *allocator,
                                               const int multithreaded);
THEORAPLAY_Decoder *THEORAPLAY_startDecode(THEORAPLAY_Io *io,
                                           const unsigned int maxframes,
                                           THEORAPLAY_VideoFormat vidfmt,
                                           const THEORAPLAY_Allocator *allocator,
                                           const int multithreaded);
void THEORAPLAY_stopDecode(THEORAPLAY_Decoder *decoder);

// call this frequently if not multithreaded! Safe no-op if multithreaded.
void THEORAPLAY_pumpDecode(THEORAPLAY_Decoder *decoder, const int maxframes);

int THEORAPLAY_isDecoding(THEORAPLAY_Decoder *decoder);
int THEORAPLAY_decodingError(THEORAPLAY_Decoder *decoder);
int THEORAPLAY_isInitialized(THEORAPLAY_Decoder *decoder);
int THEORAPLAY_hasVideoStream(THEORAPLAY_Decoder *decoder);
int THEORAPLAY_hasAudioStream(THEORAPLAY_Decoder *decoder);
unsigned int THEORAPLAY_availableVideo(THEORAPLAY_Decoder *decoder);
unsigned int THEORAPLAY_availableAudio(THEORAPLAY_Decoder *decoder);

const THEORAPLAY_AudioPacket *THEORAPLAY_getAudio(THEORAPLAY_Decoder *decoder);
void THEORAPLAY_freeAudio(const THEORAPLAY_AudioPacket *item);

const THEORAPLAY_VideoFrame *THEORAPLAY_getVideo(THEORAPLAY_Decoder *decoder);
void THEORAPLAY_freeVideo(const THEORAPLAY_VideoFrame *item);

/* Seeking is experimental! Don't complain to me if it's buggy, slow, or flakey! */
/* This returns a "seek generation". The default generation on a decoder is 0.
   If you seek, you should track the current seek generation returned by this
   function and throw out audio and video frames that aren't from this generation,
   listed in their seek_generation fields, as they were already decoded before the
   seek request. */
unsigned int THEORAPLAY_seek(THEORAPLAY_Decoder *decoder, unsigned long mspos);

#ifdef __cplusplus
}
#endif

#endif  /* include-once blocker. */

/* end of theoraplay.h ... */

