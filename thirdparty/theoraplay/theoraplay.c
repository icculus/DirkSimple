/**
 * TheoraPlay; multithreaded Ogg Theora/Ogg Vorbis decoding.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

// I wrote this with a lot of peeking at the Theora example code in
//  libtheora-1.1.1/examples/player_example.c, but this is all my own
//  code.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#ifdef _WIN32
#include <windows.h>
#define THEORAPLAY_THREAD_T    HANDLE
#define THEORAPLAY_MUTEX_T     HANDLE
#define sleepms(x) Sleep(x)
#elif defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
#define THEORAPLAY_ONLY_SINGLE_THREADED 1
#define THEORAPLAY_THREAD_T    int
#define THEORAPLAY_MUTEX_T     int
#else
#include <pthread.h>
#include <unistd.h>
#define sleepms(x) usleep((x) * 1000)
#define THEORAPLAY_THREAD_T    pthread_t
#define THEORAPLAY_MUTEX_T     pthread_mutex_t *
#endif

#if defined(__ARM_NEON__) || defined(__ARM_NEON)
#include <arm_neon.h>
#define THEORAPLAY_HAVE_NEON_INTRINSICS 1
#endif

#ifndef THEORAPLAY_ONLY_SINGLE_THREADED
#define THEORAPLAY_ONLY_SINGLE_THREADED 0
#endif

#include "theoraplay.h"
#include "theora/theoradec.h"
#include "vorbis/codec.h"

#define THEORAPLAY_INTERNAL 1

typedef THEORAPLAY_VideoFrame VideoFrame;
typedef THEORAPLAY_AudioPacket AudioPacket;

// !!! FIXME: these all count on the pixel format being TH_PF_420 for now.

typedef unsigned char *(*ConvertVideoFrameFn)(const THEORAPLAY_Allocator *allocator, const th_info *tinfo, const th_ycbcr_buffer ycbcr);

static unsigned char *ConvertVideoFrame420ToYUVPlanar(const THEORAPLAY_Allocator *allocator,
                            const th_info *tinfo, const th_ycbcr_buffer ycbcr,
                            const int p0, const int p1, const int p2)
{
    int i;
    const int w = tinfo->pic_width;
    const int h = tinfo->pic_height;
    const int yoff = (tinfo->pic_x & ~1) + ycbcr[0].stride * (tinfo->pic_y & ~1);
    const int uvoff = (tinfo->pic_x / 2) + (ycbcr[1].stride) * (tinfo->pic_y / 2);
    unsigned char *yuv = (unsigned char *) allocator->allocate(allocator, w * h * 2);
    const unsigned char *p0data = ycbcr[p0].data + yoff;
    const int p0stride = ycbcr[p0].stride;
    const unsigned char *p1data = ycbcr[p1].data + uvoff;
    const int p1stride = ycbcr[p1].stride;
    const unsigned char *p2data = ycbcr[p2].data + uvoff;
    const int p2stride = ycbcr[p2].stride;

    if (yuv)
    {
        unsigned char *dst = yuv;
        for (i = 0; i < h; i++, dst += w)
            memcpy(dst, p0data + (p0stride * i), w);
        for (i = 0; i < (h / 2); i++, dst += w/2)
            memcpy(dst, p1data + (p1stride * i), w / 2);
        for (i = 0; i < (h / 2); i++, dst += w/2)
            memcpy(dst, p2data + (p2stride * i), w / 2);
    } // if

    return yuv;
} // ConvertVideoFrame420ToYUVPlanar


static unsigned char *ConvertVideoFrame420ToYV12(const THEORAPLAY_Allocator *allocator, const th_info *tinfo, const th_ycbcr_buffer ycbcr)
{
    return ConvertVideoFrame420ToYUVPlanar(allocator, tinfo, ycbcr, 0, 2, 1);
} // ConvertVideoFrame420ToYV12


static unsigned char *ConvertVideoFrame420ToIYUV(const THEORAPLAY_Allocator *allocator, const th_info *tinfo, const th_ycbcr_buffer ycbcr)
{
    return ConvertVideoFrame420ToYUVPlanar(allocator, tinfo, ycbcr, 0, 1, 2);
} // ConvertVideoFrame420ToIYUV


// RGB
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGB
#define THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, h) ((w) * (h) * 3)
#define THEORAPLAY_CVT_RGB_OUTPUT(dst, r, g, b) { \
    *(dst++) = (unsigned char) ((r < 0) ? 0 : (r > 255) ? 255 : r); \
    *(dst++) = (unsigned char) ((g < 0) ? 0 : (g > 255) ? 255 : g); \
    *(dst++) = (unsigned char) ((b < 0) ? 0 : (b > 255) ? 255 : b); \
}
#ifdef THEORAPLAY_HAVE_NEON_INTRINSICS
#define THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES 1
#include "theoraplay_cvtrgb.h"  /* build out the scalar version. */
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGB_NEON
#define THEORAPLAY_CVT_RGB_USE_NEON 1
#define THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, rgba_x4) { /* without alpha, we need to store to a 16-byte aligned piece of stack and copy to dst.  :/ */ \
    uint8_t aligned_pixels[16]  __attribute__ ((aligned (16))); \
    vst1q_u8(aligned_pixels, rgba_x4); \
    dst[0] = aligned_pixels[0]; \
    dst[1] = aligned_pixels[1]; \
    dst[2] = aligned_pixels[2]; \
    dst[3] = aligned_pixels[4]; \
    dst[4] = aligned_pixels[5]; \
    dst[5] = aligned_pixels[6]; \
    dst[6] = aligned_pixels[8]; \
    dst[7] = aligned_pixels[9]; \
    dst[8] = aligned_pixels[10]; \
    dst[9] = aligned_pixels[12]; \
    dst[10] = aligned_pixels[13]; \
    dst[11] = aligned_pixels[14]; \
    dst += 12; \
}
#endif
#include "theoraplay_cvtrgb.h"

// RGBA
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGBA
#define THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, h) ((w) * (h) * 4)
#define THEORAPLAY_CVT_RGB_OUTPUT(dst, r, g, b) { \
    *(dst++) = (unsigned char) ((r < 0) ? 0 : (r > 255) ? 255 : r); \
    *(dst++) = (unsigned char) ((g < 0) ? 0 : (g > 255) ? 255 : g); \
    *(dst++) = (unsigned char) ((b < 0) ? 0 : (b > 255) ? 255 : b); \
    *(dst++) = 0xFF; \
}
#ifdef THEORAPLAY_HAVE_NEON_INTRINSICS
#define THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES 1
#include "theoraplay_cvtrgb.h"  /* build out the scalar version. */
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGBA_NEON
#define THEORAPLAY_CVT_RGB_USE_NEON 1
#define THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, rgba_x4) { vst1q_u8(dst, rgba_x4); dst += 16; }
#endif
#include "theoraplay_cvtrgb.h"

// BGRA
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToBGRA
#define THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, h) ((w) * (h) * 4)
#define THEORAPLAY_CVT_RGB_OUTPUT(dst, r, g, b) { \
    *(dst++) = (unsigned char) ((b < 0) ? 0 : (b > 255) ? 255 : b); \
    *(dst++) = (unsigned char) ((g < 0) ? 0 : (g > 255) ? 255 : g); \
    *(dst++) = (unsigned char) ((r < 0) ? 0 : (r > 255) ? 255 : r); \
    *(dst++) = 0xFF; \
}
#ifdef THEORAPLAY_HAVE_NEON_INTRINSICS
#define THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES 1
#include "theoraplay_cvtrgb.h"  /* build out the scalar version. */
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToBGRA_NEON
#define THEORAPLAY_CVT_RGB_USE_NEON 1
// !!! FIXME: we can probably find some bit-swizzling magic to do these on the vector registers and then store them out.
#define THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, rgba_x4) { \
    unsigned char tmp; \
    vst1q_u8(dst, rgba_x4); \
    tmp = dst[0]; dst[0] = dst[2]; dst[2] = tmp; \
    tmp = dst[4]; dst[4] = dst[6]; dst[6] = tmp; \
    tmp = dst[8]; dst[8] = dst[10]; dst[10] = tmp; \
    tmp = dst[12]; dst[12] = dst[14]; dst[14] = tmp; \
    dst += 16; \
}
#endif
#include "theoraplay_cvtrgb.h"

// RGB565
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGB565
#define THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, h) ((w) * (h) * 2)
#define THEORAPLAY_CVT_RGB_OUTPUT(dst, r, g, b) { \
    unsigned short *dst16 = (unsigned short *) dst; \
    const int r5 = ((r < 0) ? 0 : (r > 255) ? 255 : r) >> 3; \
    const int g6 = ((g < 0) ? 0 : (g > 255) ? 255 : g) >> 2; \
    const int b5 = ((b < 0) ? 0 : (b > 255) ? 255 : b) >> 3; \
    *dst16 = (unsigned short) ((r5 << 11) | (g6 << 5) | b5); \
    dst += 2; \
}
#ifdef THEORAPLAY_HAVE_NEON_INTRINSICS
#define THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES 1
#include "theoraplay_cvtrgb.h"  /* build out the scalar version. */
#define THEORAPLAY_CVT_FNNAME_420 ConvertVideoFrame420ToRGB565_NEON
#define THEORAPLAY_CVT_RGB_USE_NEON 1
// !!! FIXME: this can maybe at least do the initial bitshifts on the NEON registers...
#define THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, rgba_x4) { \
    uint8_t aligned_pixels[16]  __attribute__ ((aligned (16))); \
    uint16_t *dst16 = (uint16_t *) dst; \
    vst1q_u8(aligned_pixels, rgba_x4); \
    dst16[0] = ((((uint16_t) aligned_pixels[0]) >> 3) << 11) | ((((uint16_t) aligned_pixels[1]) >> 2) << 5) | (((uint16_t) aligned_pixels[2]) >> 3); \
    dst16[1] = ((((uint16_t) aligned_pixels[4]) >> 3) << 11) | ((((uint16_t) aligned_pixels[5]) >> 2) << 5) | (((uint16_t) aligned_pixels[6]) >> 3); \
    dst16[2] = ((((uint16_t) aligned_pixels[8]) >> 3) << 11) | ((((uint16_t) aligned_pixels[9]) >> 2) << 5) | (((uint16_t) aligned_pixels[10]) >> 3); \
    dst16[3] = ((((uint16_t) aligned_pixels[12]) >> 3) << 11) | ((((uint16_t) aligned_pixels[13]) >> 2) << 5) | (((uint16_t) aligned_pixels[14]) >> 3); \
    dst += 8; \
}
#endif
#include "theoraplay_cvtrgb.h"

// !!! FIXME: these volatiles really need to become atomics.
typedef struct TheoraDecoder
{
    // Thread wrangling...
    int thread_created;
    THEORAPLAY_MUTEX_T lock;
    volatile int halt;
    int thread_done;
    THEORAPLAY_THREAD_T worker;

    // API state...
    THEORAPLAY_Allocator allocator;
    THEORAPLAY_Io *io;
    unsigned int maxframes;  // Max video frames to buffer.
    volatile unsigned int prepped;
    volatile unsigned int videocount;  // currently buffered frames.
    volatile unsigned int audioms;  // currently buffered audio samples.
    volatile int hasvideo;
    volatile int hasaudio;
    volatile int decode_error;
    volatile unsigned int seek_generation;
    volatile unsigned long new_seek_position_ms;

    THEORAPLAY_VideoFormat vidfmt;
    ConvertVideoFrameFn vidcvt;

    VideoFrame *videolist;
    VideoFrame *videolisttail;

    AudioPacket *audiolist;
    AudioPacket *audiolisttail;

    long streamlen;
    unsigned int current_seek_generation;
    double fps;
    int was_error;
    int eos;

    // Too much Ogg/Vorbis/Theora state...
    ogg_packet packet;
    ogg_sync_state sync;
    ogg_page page;
    int vpackets;
    int vserialno;
    vorbis_info vinfo;
    vorbis_comment vcomment;
    ogg_stream_state vstream;
    int vdsp_init;
    vorbis_dsp_state vdsp;
    int tpackets;
    int tserialno;
    th_info tinfo;
    th_comment tcomment;
    ogg_stream_state tstream;
    int vblock_init;
    vorbis_block vblock;
    th_dec_ctx *tdec;
    th_setup_info *tsetup;
    ogg_int64_t granulepos;
    int resolving_audio_seek;
    int resolving_video_seek;
    int need_keyframe;
    unsigned long seek_target;
    int bos;
} TheoraDecoder;


#if THEORAPLAY_ONLY_SINGLE_THREADED
static inline int Thread_Create(TheoraDecoder *ctx, void *(*routine) (void*))
{
    ctx->worker = 0;
    return -1;
}
static inline void Thread_Join(THEORAPLAY_THREAD_T thread)
{
}
static inline THEORAPLAY_MUTEX_T Mutex_Create(TheoraDecoder *ctx)
{
    return (THEORAPLAY_MUTEX_T) (size_t) 0x0001;
}
static inline void Mutex_Destroy(TheoraDecoder *ctx, THEORAPLAY_MUTEX_T mutex)
{
}
static inline void Mutex_Lock(THEORAPLAY_MUTEX_T mutex)
{
}
static inline void Mutex_Unlock(THEORAPLAY_MUTEX_T mutex)
{
}
#elif defined(_WIN32)
static inline int Thread_Create(TheoraDecoder *ctx, void *(*routine) (void*))
{
    ctx->worker = CreateThread(
        NULL,
        0,
        (LPTHREAD_START_ROUTINE) routine,
        (LPVOID) ctx,
        0,
        NULL
    );
    return (ctx->worker == NULL);
}
static inline void Thread_Join(THEORAPLAY_THREAD_T thread)
{
    WaitForSingleObject(thread, INFINITE);
    CloseHandle(thread);
}
static inline THEORAPLAY_MUTEX_T Mutex_Create(TheoraDecoder *ctx)
{
    return CreateMutex(NULL, FALSE, NULL);
}
static inline void Mutex_Destroy(TheoraDecoder *ctx, THEORAPLAY_MUTEX_T mutex)
{
    CloseHandle(mutex);
}
static inline void Mutex_Lock(THEORAPLAY_MUTEX_T mutex)
{
    WaitForSingleObject(mutex, INFINITE);
}
static inline void Mutex_Unlock(THEORAPLAY_MUTEX_T mutex)
{
    ReleaseMutex(mutex);
}
#else
static inline int Thread_Create(TheoraDecoder *ctx, void *(*routine) (void*))
{
    return pthread_create(&ctx->worker, NULL, routine, ctx);
}
static inline void Thread_Join(THEORAPLAY_THREAD_T thread)
{
    pthread_join(thread, NULL);
}
static inline THEORAPLAY_MUTEX_T Mutex_Create(TheoraDecoder *ctx)
{
    THEORAPLAY_MUTEX_T retval = (THEORAPLAY_MUTEX_T) ctx->allocator.allocate(&ctx->allocator, sizeof (*retval));
    if (retval) {
        if (pthread_mutex_init(retval, NULL) != 0) {
            ctx->allocator.deallocate(&ctx->allocator, retval);
            retval = NULL;
        }
    }
    return retval;
}
static inline void Mutex_Destroy(TheoraDecoder *ctx, THEORAPLAY_MUTEX_T mutex)
{
    if (mutex) {
        pthread_mutex_destroy(mutex);
        ctx->allocator.deallocate(&ctx->allocator, mutex);
    }
}
static inline void Mutex_Lock(THEORAPLAY_MUTEX_T mutex)
{
    pthread_mutex_lock(mutex);
}
static inline void Mutex_Unlock(THEORAPLAY_MUTEX_T mutex)
{
    pthread_mutex_unlock(mutex);
}
#endif


static int FeedMoreOggData(THEORAPLAY_Io *io, ogg_sync_state *sync)
{
    long buflen = 4096;
    char *buffer = ogg_sync_buffer(sync, buflen);
    if (buffer == NULL)
        return -1;

    buflen = io->read(io, buffer, buflen);
    if (buflen <= 0)
        return 0;

    return (ogg_sync_wrote(sync, buflen) == 0) ? 1 : -1;
} // FeedMoreOggData


static void QueueOggPage(TheoraDecoder *ctx)
{
    // make sure we initialized the stream before using pagein, but the stream
    //  will know to ignore pages that aren't meant for it, so pass to both.
    if (ctx->tpackets)
        ogg_stream_pagein(&ctx->tstream, &ctx->page);
    if (ctx->vpackets)
        ogg_stream_pagein(&ctx->vstream, &ctx->page);
}

// this currently blocks, so plan ahead if pumping and not threading.
static void PrepareDecoder(TheoraDecoder *ctx)
{
    while (!ctx->halt && ctx->bos)
    {
        if (FeedMoreOggData(ctx->io, &ctx->sync) <= 0)
            goto cleanup;

        // parse out the initial header.
        while ( (!ctx->halt) && (ogg_sync_pageout(&ctx->sync, &ctx->page) > 0) )
        {
            ogg_stream_state test;
            int serialno;

            if (!ogg_page_bos(&ctx->page))  // not a header.
            {
                QueueOggPage(ctx);
                ctx->bos = 0;
                break;
            } // if

            serialno = ogg_page_serialno(&ctx->page);
            ogg_stream_init(&test, serialno);
            ogg_stream_pagein(&test, &ctx->page);
            ogg_stream_packetout(&test, &ctx->packet);

            if (!ctx->tpackets && (th_decode_headerin(&ctx->tinfo, &ctx->tcomment, &ctx->tsetup, &ctx->packet) >= 0))
            {
                memcpy(&ctx->tstream, &test, sizeof (test));
                ctx->tpackets = 1;
                ctx->tserialno = serialno;
            } // if
            else if (!ctx->vpackets && (vorbis_synthesis_headerin(&ctx->vinfo, &ctx->vcomment, &ctx->packet) >= 0))
            {
                memcpy(&ctx->vstream, &test, sizeof (test));
                ctx->vpackets = 1;
                ctx->vserialno = serialno;
            } // else if
            else
            {
                // whatever it is, we don't care about it
                ogg_stream_clear(&test);
            } // else
        } // while
    } // while

    // no audio OR video?
    if (ctx->halt || (!ctx->vpackets && !ctx->tpackets))
        goto cleanup;

    // apparently there are two more theora and two more vorbis headers next.
    while ((!ctx->halt) && ((ctx->tpackets && (ctx->tpackets < 3)) || (ctx->vpackets && (ctx->vpackets < 3))))
    {
        while (!ctx->halt && ctx->tpackets && (ctx->tpackets < 3))
        {
            if (ogg_stream_packetout(&ctx->tstream, &ctx->packet) != 1)
                break; // get more data?
            if (!th_decode_headerin(&ctx->tinfo, &ctx->tcomment, &ctx->tsetup, &ctx->packet))
                goto cleanup;
            ctx->tpackets++;
        } // while

        while (!ctx->halt && ctx->vpackets && (ctx->vpackets < 3))
        {
            if (ogg_stream_packetout(&ctx->vstream, &ctx->packet) != 1)
                break;  // get more data?
            if (vorbis_synthesis_headerin(&ctx->vinfo, &ctx->vcomment, &ctx->packet))
                goto cleanup;
            ctx->vpackets++;
        } // while

        // get another page, try again?
        if (ogg_sync_pageout(&ctx->sync, &ctx->page) > 0)
            QueueOggPage(ctx);
        else if (FeedMoreOggData(ctx->io, &ctx->sync) <= 0)
            goto cleanup;
    } // while

    // okay, now we have our streams, ready to set up decoding.
    if (!ctx->halt && ctx->tpackets)
    {
        // th_decode_alloc() docs say to check for insanely large frames yourself.
        if ((ctx->tinfo.frame_width > 99999) || (ctx->tinfo.frame_height > 99999))
            goto cleanup;

        // We treat "unspecified" as NTSC. *shrug*
        if ( (ctx->tinfo.colorspace != TH_CS_UNSPECIFIED) &&
             (ctx->tinfo.colorspace != TH_CS_ITU_REC_470M) &&
             (ctx->tinfo.colorspace != TH_CS_ITU_REC_470BG) )
        {
            assert(0 && "Unsupported colorspace.");  // !!! FIXME
            goto cleanup;
        } // if

        if (ctx->tinfo.pixel_fmt != TH_PF_420) { assert(0); goto cleanup; } // !!! FIXME

        if (ctx->tinfo.fps_denominator != 0)
            ctx->fps = ((double) ctx->tinfo.fps_numerator) / ((double) ctx->tinfo.fps_denominator);

        ctx->tdec = th_decode_alloc(&ctx->tinfo, ctx->tsetup);
        if (!ctx->tdec) goto cleanup;

        // Set decoder to maximum post-processing level.
        //  Theoretically we could try dropping this level if we're not keeping up.
        int pp_level_max = 0;
        // !!! FIXME: maybe an API to set this?
        //th_decode_ctl(ctx->tdec, TH_DECCTL_GET_PPLEVEL_MAX, &pp_level_max, sizeof(pp_level_max));
        th_decode_ctl(ctx->tdec, TH_DECCTL_SET_PPLEVEL, &pp_level_max, sizeof(pp_level_max));
    } // if

    // Done with this now.
    if (ctx->tsetup != NULL)
    {
        th_setup_free(ctx->tsetup);
        ctx->tsetup = NULL;
    } // if

    if (!ctx->halt && ctx->vpackets)
    {
        ctx->vdsp_init = (vorbis_synthesis_init(&ctx->vdsp, &ctx->vinfo) == 0);
        if (!ctx->vdsp_init)
            goto cleanup;
        ctx->vblock_init = (vorbis_block_init(&ctx->vdsp, &ctx->vblock) == 0);
        if (!ctx->vblock_init)
            goto cleanup;
    } // if

    // Now we can start the actual decoding!
    // Note that audio and video don't _HAVE_ to start simultaneously.

    Mutex_Lock(ctx->lock);
    ctx->prepped = 1;
    ctx->hasvideo = (ctx->tpackets != 0);
    ctx->hasaudio = (ctx->vpackets != 0);
    Mutex_Unlock(ctx->lock);

cleanup:  // we will do actual cleanup when closing the decoder.
    return;
}

// This massive function is where all the effort happens.
static int PumpDecoder(TheoraDecoder *ctx, int desired_frames)
{
    int had_new_video_frames = 0;

    if (!ctx->prepped)
    {
        PrepareDecoder(ctx);
        return 0;
    } // if

    if (ctx->thread_done)
        return 0;

    while (!ctx->halt && !ctx->eos && (desired_frames > 0))
    {
        int need_pages = 0;  // need more Ogg pages?

        if (ctx->current_seek_generation != ctx->seek_generation)  // seek requested
        {
            unsigned long targetms;
            long seekpos;
            long lo, hi;
            int found = 0;

            if (!ctx->io->seek)
                goto cleanup;  // seeking unsupported.

            if (ctx->streamlen == -1)  // just check this once in case it's expensive.
            {
                ctx->streamlen = ctx->io->streamlen ? ctx->io->streamlen(ctx->io) : -1;
                if (ctx->streamlen == -1)
                    goto cleanup;  // i/o error, unsupported, etc.
            } // if

            // We check ctx->seek_generation without a lock as this goes on, so if they mismatch we
            //  drop what we're doing and prepare to seek to a new location. But here we hold a lock
            //  so we can avoid the race condition where the app is halfway through requesting a
            //  seek while we're reading in these variables.
            Mutex_Lock(ctx->lock);
            ctx->current_seek_generation = ctx->seek_generation;
            targetms = ctx->new_seek_position_ms;
            Mutex_Unlock(ctx->lock);

            lo = 0;
            hi = ctx->streamlen;

            if (targetms < 1000)
                hi = 0;  /* as an optimization, just jump to the start of file if seeking within the first second, instead of binary searching. */

            seekpos = (lo / 2) + (hi / 2);

            while ((!ctx->halt) && (ctx->current_seek_generation == ctx->seek_generation))
            {
                //const int max_keyframe_distance = 1 << ctx->tinfo.keyframe_granule_shift;

                // Do a binary search through the stream to find our starting point.
                // This idea came from libtheoraplayer (no relation to theoraplay).
                if (ctx->io->seek(ctx->io, seekpos) == -1)
                    goto cleanup;  // oh well.

                ctx->granulepos = -1;
                ogg_sync_reset(&ctx->sync);
                memset(&ctx->page, '\0', sizeof (ctx->page));
                ogg_sync_pageseek(&ctx->sync, &ctx->page);

                while (!ctx->halt && (ctx->current_seek_generation == ctx->seek_generation))
                {
                    if (ogg_sync_pageout(&ctx->sync, &ctx->page) != 1)
                    {
                        if (FeedMoreOggData(ctx->io, &ctx->sync) <= 0)
                            goto cleanup;
                        continue;
                    } // if

                    ctx->granulepos = ogg_page_granulepos(&ctx->page);
                    if (ctx->granulepos >= 0)
                    {
                        const int serialno = ogg_page_serialno(&ctx->page);
                        unsigned long ms;

                        if (ctx->tpackets)  // always tee off video frames if possible.
                        {
                            if (serialno != ctx->tserialno)
                                continue;
                            ms = (unsigned long) (th_granule_time(ctx->tdec, ctx->granulepos) * 1000.0);
                        } // else
                        else
                        {
                            if (serialno != ctx->vserialno)
                                continue;
                            ms = (unsigned long) (vorbis_granule_time(&ctx->vdsp, ctx->granulepos) * 1000.0);
                        } // else

                        if ((ms < targetms) && ((targetms - ms) >= 500) && ((targetms - ms) <= 1000))   // !!! FIXME: tweak this number?
                            found = 1;  // found something close enough to the target!
                        else  // adjust binary search position and try again.
                        {
                            const long newpos = (lo / 2) + (hi / 2);
                            if (targetms > ms)
                                lo = newpos;
                            else
                                hi = newpos;
                        } // else
                        break;
                    } // if
                } // while

                if (found)
                    break;

                const long newseekpos = (lo / 2) + (hi / 2);
                if (seekpos == newseekpos)
                    break;  // we did the best we could, just go from here.
                seekpos = newseekpos;
            } // while

            // at this point, we have seek'd to something reasonably close to our target. Now decode until we're as close as possible to it.
            vorbis_synthesis_restart(&ctx->vdsp);
            ctx->resolving_audio_seek = ctx->vpackets;
            ctx->resolving_video_seek = ctx->tpackets;
            ctx->seek_target = targetms;
            ctx->need_keyframe = ctx->tpackets;
        } // if

        // Try to read as much audio as we can at once. We limit the outer
        //  loop to one video frame and as much audio as we can eat.
        while (!ctx->halt && ctx->vpackets)
        {
            const double audiotime = vorbis_granule_time(&ctx->vdsp, ctx->vdsp.granulepos);
            const unsigned int playms = (unsigned int) (audiotime * 1000.0);
            float **pcm = NULL;
            int frames;

            if (ctx->current_seek_generation != ctx->seek_generation)
                break;  // seek requested? Break out of the loop right away so we can handle it; this loop's work would be wasted.

            if (ctx->resolving_audio_seek)
            {
                if (ctx->seek_target < 1000)   // if the seek target is the start of the data, assume we're good even before audiotime is valid. As soon as we have data, ship it.
                    ctx->resolving_audio_seek = 0;
                else if ((audiotime >= 0.0) && ((playms >= ctx->seek_target) || ((ctx->seek_target - playms) <= (unsigned long) (1000.0 / ctx->fps))))
                    ctx->resolving_audio_seek = 0;
            }

            frames = vorbis_synthesis_pcmout(&ctx->vdsp, &pcm);
            if (frames > 0)
            {
                if (!ctx->resolving_audio_seek)
                {
                    const int channels = ctx->vinfo.channels;
                    int chanidx, frameidx;
                    float *samples;
                    AudioPacket *item = (AudioPacket *) ctx->allocator.allocate(&ctx->allocator, sizeof (AudioPacket));
                    if (item == NULL) goto cleanup;
                    item->seek_generation = ctx->current_seek_generation;
                    item->playms = playms;
                    item->channels = channels;
                    item->freq = ctx->vinfo.rate;
                    item->frames = frames;
                    item->samples = (float *) ctx->allocator.allocate(&ctx->allocator, sizeof (float) * frames * channels);
                    item->next = NULL;

                    if (item->samples == NULL)
                    {
                        free(item);
                        goto cleanup;
                    } // if

                    // I bet this beats the crap out of the CPU cache...
                    samples = item->samples;
                    for (frameidx = 0; frameidx < frames; frameidx++)
                    {
                        for (chanidx = 0; chanidx < channels; chanidx++)
                            *(samples++) = pcm[chanidx][frameidx];
                    } // for

                    //printf("Decoded %d frames of audio.\n", (int) frames);
                    Mutex_Lock(ctx->lock);
                    ctx->audioms += item->playms;
                    if (ctx->audiolisttail)
                    {
                        assert(ctx->audiolist);
                        ctx->audiolisttail->next = item;
                    } // if
                    else
                    {
                        assert(!ctx->audiolist);
                        ctx->audiolist = item;
                    } // else
                    ctx->audiolisttail = item;
                    Mutex_Unlock(ctx->lock);
                } // if

                vorbis_synthesis_read(&ctx->vdsp, frames);  // we ate everything.
            } // if
            else  // no audio available left in current packet?
            {
                // try to feed another packet to the Vorbis stream...
                if (ogg_stream_packetout(&ctx->vstream, &ctx->packet) <= 0)
                {
                    if (!ctx->tpackets)
                        need_pages = 1; // no video, get more pages now.
                    break;  // we'll get more pages when the video catches up.
                } // if
                else
                {
                    if (vorbis_synthesis(&ctx->vblock, &ctx->packet) == 0)
                        vorbis_synthesis_blockin(&ctx->vdsp, &ctx->vblock);
                } // else
            } // else
        } // while

        if (!ctx->halt && ctx->tpackets && (ctx->current_seek_generation == ctx->seek_generation))
        {
            // Theora, according to example_player.c, is
            //  "one [packet] in, one [frame] out."
            if (ogg_stream_packetout(&ctx->tstream, &ctx->packet) <= 0)
                need_pages = 1;
            else
            {
                // you have to guide the Theora decoder to get meaningful timestamps, apparently.  :/
                if (ctx->packet.granulepos >= 0)
                    th_decode_ctl(ctx->tdec, TH_DECCTL_SET_GRANPOS, &ctx->packet.granulepos, sizeof (ctx->packet.granulepos));

                if (th_decode_packetin(ctx->tdec, &ctx->packet, &ctx->granulepos) == 0)  // new frame!
                {
                    const double videotime = th_granule_time(ctx->tdec, ctx->granulepos);
                    const unsigned int playms = (unsigned int) (videotime * 1000.0);

                    if (ctx->need_keyframe && th_packet_iskeyframe(&ctx->packet))
                        ctx->need_keyframe = 0;

                    if (ctx->resolving_video_seek && !ctx->need_keyframe && ((playms >= ctx->seek_target) || ((ctx->seek_target - playms) <= (unsigned long) (1000.0 / ctx->fps))))
                        ctx->resolving_video_seek = 0;

                    if (!ctx->resolving_video_seek)
                    {
                        th_ycbcr_buffer ycbcr;
                        if (th_decode_ycbcr_out(ctx->tdec, ycbcr) == 0)
                        {
                            VideoFrame *item = (VideoFrame *) ctx->allocator.allocate(&ctx->allocator, sizeof (VideoFrame));
                            if (item == NULL) goto cleanup;
                            item->seek_generation = ctx->current_seek_generation;
                            item->playms = playms;
                            item->fps = ctx->fps;
                            item->width = ctx->tinfo.pic_width;
                            item->height = ctx->tinfo.pic_height;
                            item->format = ctx->vidfmt;
                            item->pixels = ctx->vidcvt(&ctx->allocator, &ctx->tinfo, ycbcr);
                            item->next = NULL;

                            if (item->pixels == NULL)
                            {
                                free(item);
                                goto cleanup;
                            } // if

                            //printf("Decoded another video frame.\n");
                            Mutex_Lock(ctx->lock);
                            if (ctx->videolisttail)
                            {
                                assert(ctx->videolist);
                                ctx->videolisttail->next = item;
                            } // if
                            else
                            {
                                assert(!ctx->videolist);
                                ctx->videolist = item;
                            } // else
                            ctx->videolisttail = item;
                            ctx->videocount++;

                            desired_frames--;

                            // if we're full, consider this a full pump.
                            if (ctx->videocount >= ctx->maxframes)
                                desired_frames = 0;
                            Mutex_Unlock(ctx->lock);

                            had_new_video_frames = 1;
                        } // if
                    } // if
                } // if
            } // else
        } // if

        if (!ctx->halt && need_pages && (ctx->current_seek_generation == ctx->seek_generation))
        {
            const int rc = FeedMoreOggData(ctx->io, &ctx->sync);
            if (rc == 0)
                ctx->eos = 1;  // end of stream
            else if (rc < 0)
                goto cleanup;  // i/o error, etc.
            else
            {
                while (!ctx->halt && (ogg_sync_pageout(&ctx->sync, &ctx->page) > 0))
                    QueueOggPage(ctx);
            } // else
        } // if
    } // while

    ctx->was_error = 0;

cleanup:
    ctx->decode_error = (!ctx->halt && ctx->was_error);
    ctx->thread_done = (ctx->halt || ctx->eos || ctx->decode_error);

    return had_new_video_frames;
} // PumpDecoder


static void *WorkerThread(void *_this)
{
#if !THEORAPLAY_ONLY_SINGLE_THREADED
    TheoraDecoder *ctx = (TheoraDecoder *) _this;
    while (!ctx->thread_done)
    {
        const int had_new_video_frames = PumpDecoder(ctx, ctx->maxframes);
        // Sleep the process until we have space for more frames.
        if (had_new_video_frames && !ctx->thread_done)
        {
            int go_on = !ctx->halt;
            //printf("Sleeping.\n");
            while (go_on)
            {
                // !!! FIXME: This is stupid. I should use a semaphore for this.
                Mutex_Lock(ctx->lock);
                go_on = !ctx->halt && (ctx->videocount >= ctx->maxframes);
                Mutex_Unlock(ctx->lock);
                if (go_on)
                    sleepms(10);
            } // while
            //printf("Awake!\n");
        } // if
    }

    //printf("Worker thread is done.\n");
#endif
    return NULL;
} // WorkerThread

#ifndef THEORAPLAY_NO_FOPEN_FALLBACK
typedef struct THEORAPLAY_IoUserData
{
    FILE *f;
    THEORAPLAY_Allocator allocator;
} THEORAPLAY_IoUserData;

static long IoFopenRead(THEORAPLAY_Io *io, void *buf, long buflen)
{
    FILE *f = ((THEORAPLAY_IoUserData *) io->userdata)->f;
    const size_t br = fread(buf, 1, buflen, f);
    if ((br == 0) && ferror(f))
        return -1;
    return (long) br;
} // IoFopenRead

static long IoFopenStreamLen(THEORAPLAY_Io *io)
{
    FILE *f = ((THEORAPLAY_IoUserData *) io->userdata)->f;
    const long origpos = ftell(f);
    long retval = -1;
    if (fseek(f, 0, SEEK_END) == 0) {
        retval = ftell(f);
    }
    fseek(f, origpos, SEEK_SET);
    return retval;
} // IoFopenStreamLen

static int IoFopenSeek(THEORAPLAY_Io *io, long absolute_offset)
{
    FILE *f = ((THEORAPLAY_IoUserData *) io->userdata)->f;
    return fseek(f, absolute_offset, SEEK_SET);
} // IoFopenSeek

static void IoFopenClose(THEORAPLAY_Io *io)
{
    THEORAPLAY_IoUserData *userdata = (THEORAPLAY_IoUserData *) io->userdata;
    fclose(userdata->f);
    userdata->allocator.deallocate(&userdata->allocator, io);
} // IoFopenClose
#endif

#ifndef THEORAPLAY_NO_MALLOC_FALLBACK
static void *malloc_fallback_allocate(const THEORAPLAY_Allocator *allocator, unsigned int len) { return malloc((size_t) len); }
static void malloc_fallback_deallocate(const THEORAPLAY_Allocator *allocator, void *ptr) { free(ptr); }
#endif

THEORAPLAY_Decoder *THEORAPLAY_startDecodeFile(const char *fname,
                                               const unsigned int maxframes,
                                               THEORAPLAY_VideoFormat vidfmt,
                                               const THEORAPLAY_Allocator *allocator,
                                               const int multithreaded)
{
#ifdef THEORAPLAY_NO_FOPEN_FALLBACK
    return NULL;
#else
    THEORAPLAY_Io *io;

    #ifdef THEORAPLAY_NO_MALLOC_FALLBACK
    if (allocator == NULL) {
        return NULL;
    }
    #else
    THEORAPLAY_Allocator malloc_fallback_allocator;
    if (allocator == NULL) {
        malloc_fallback_allocator.allocate = malloc_fallback_allocate;
        malloc_fallback_allocator.deallocate = malloc_fallback_deallocate;
        malloc_fallback_allocator.userdata = NULL;
        allocator = &malloc_fallback_allocator;
    }
    #endif

    io = (THEORAPLAY_Io *) allocator->allocate(allocator, sizeof (THEORAPLAY_Io) + sizeof (THEORAPLAY_IoUserData));
    if (io == NULL)
        return NULL;

    THEORAPLAY_IoUserData *userdata = (THEORAPLAY_IoUserData *) (io + 1);  /* we allocated it right after the Io interface */

    memcpy(&userdata->allocator, allocator, sizeof (THEORAPLAY_Allocator));

    userdata->f = fopen(fname, "rb");
    if (userdata->f == NULL)
    {
        allocator->deallocate(allocator, io);
        return NULL;
    } // if

    io->read = IoFopenRead;
    io->seek = IoFopenSeek;
    io->streamlen = IoFopenStreamLen;
    io->close = IoFopenClose;
    io->userdata = userdata;

    return THEORAPLAY_startDecode(io, maxframes, vidfmt, allocator, multithreaded);
#endif
} // THEORAPLAY_startDecodeFile


THEORAPLAY_Decoder *THEORAPLAY_startDecode(THEORAPLAY_Io *io,
                                           const unsigned int maxframes,
                                           THEORAPLAY_VideoFormat vidfmt,
                                           const THEORAPLAY_Allocator *allocator,
                                           const int multithreaded)
{
    TheoraDecoder *ctx = NULL;
    ConvertVideoFrameFn vidcvt = NULL;

    #ifdef THEORAPLAY_NO_MALLOC_FALLBACK
    if (allocator == NULL) {
        return NULL;
    }
    #else
    THEORAPLAY_Allocator malloc_fallback_allocator;
    if (allocator == NULL) {
        malloc_fallback_allocator.allocate = malloc_fallback_allocate;
        malloc_fallback_allocator.deallocate = malloc_fallback_deallocate;
        malloc_fallback_allocator.userdata = NULL;
        allocator = &malloc_fallback_allocator;
    }
    #endif

    #if THEORAPLAY_ONLY_SINGLE_THREADED
    if (multithreaded)
        return NULL;
    #endif

    switch (vidfmt)
    {
        // !!! FIXME: current expects TH_PF_420.
        #define VIDCVT(t) case THEORAPLAY_VIDFMT_##t: vidcvt = ConvertVideoFrame420To##t; break;
        VIDCVT(YV12)
        VIDCVT(IYUV)
        #undef VIDCVT

        // !!! FIXME: this should actually _check_ for NEON support at runtime (the `&& 1` part).
        #ifdef THEORAPLAY_HAVE_NEON_INTRINSICS
        #define VIDCVT_NEON(t) if (!vidcvt && 1) { vidcvt = ConvertVideoFrame420To##t##_NEON; }
        #else
        #define VIDCVT_NEON(t)
        #endif

        #define VIDCVT(t) case THEORAPLAY_VIDFMT_##t: \
            VIDCVT_NEON(t); \
            if (!vidcvt) { vidcvt = ConvertVideoFrame420To##t; } \
            break;

        VIDCVT(RGB)
        VIDCVT(RGBA)
        VIDCVT(BGRA)
        VIDCVT(RGB565)
        #undef VIDCVT
        default: goto startdecode_failed;  // invalid/unsupported format.
    } // switch

    ctx = (TheoraDecoder *) allocator->allocate(allocator, sizeof (TheoraDecoder));
    if (ctx == NULL)
        goto startdecode_failed;

    memset(ctx, '\0', sizeof (TheoraDecoder));
    memcpy(&ctx->allocator, allocator, sizeof (THEORAPLAY_Allocator));
    ctx->maxframes = maxframes;
    ctx->vidfmt = vidfmt;
    ctx->vidcvt = vidcvt;
    ctx->io = io;
    ctx->streamlen = -1;
    ctx->was_error = 1;  // resets to 0 at the end.
    ctx->bos = 1;

    ogg_sync_init(&ctx->sync);
    vorbis_info_init(&ctx->vinfo);
    vorbis_comment_init(&ctx->vcomment);
    th_comment_init(&ctx->tcomment);
    th_info_init(&ctx->tinfo);

    if (!multithreaded)
        return (THEORAPLAY_Decoder *) ctx;
    else
    {
        ctx->lock = Mutex_Create(ctx);
        if (ctx->lock)
        {
            ctx->thread_created = (Thread_Create(ctx, WorkerThread) == 0);
            if (ctx->thread_created)
                return (THEORAPLAY_Decoder *) ctx;
            Mutex_Destroy(ctx, ctx->lock);
        } // if
    } // else

startdecode_failed:
    if (ctx->lock)
        Mutex_Destroy(ctx, ctx->lock);
    io->close(io);
    allocator->deallocate(allocator, ctx);
    return NULL;
} // THEORAPLAY_startDecode


void THEORAPLAY_stopDecode(THEORAPLAY_Decoder *decoder)
{
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;
    if (!ctx)
        return;

    if (ctx->thread_created)
    {
        ctx->halt = 1;
        Thread_Join(ctx->worker);
        Mutex_Destroy(ctx, ctx->lock);
    } // if

    VideoFrame *videolist = ctx->videolist;
    while (videolist)
    {
        VideoFrame *next = videolist->next;
        free(videolist->pixels);
        free(videolist);
        videolist = next;
    } // while

    AudioPacket *audiolist = ctx->audiolist;
    while (audiolist)
    {
        AudioPacket *next = audiolist->next;
        free(audiolist->samples);
        free(audiolist);
        audiolist = next;
    } // while

    if (ctx->tdec != NULL) th_decode_free(ctx->tdec);
    if (ctx->tsetup != NULL) th_setup_free(ctx->tsetup);
    if (ctx->vblock_init) vorbis_block_clear(&ctx->vblock);
    if (ctx->vdsp_init) vorbis_dsp_clear(&ctx->vdsp);
    if (ctx->tpackets) ogg_stream_clear(&ctx->tstream);
    if (ctx->vpackets) ogg_stream_clear(&ctx->vstream);
    th_info_clear(&ctx->tinfo);
    th_comment_clear(&ctx->tcomment);
    vorbis_comment_clear(&ctx->vcomment);
    vorbis_info_clear(&ctx->vinfo);
    ogg_sync_clear(&ctx->sync);

    if (ctx->io && ctx->io->close)
        ctx->io->close(ctx->io);

    free(ctx);
} // THEORAPLAY_stopDecode


void THEORAPLAY_pumpDecode(THEORAPLAY_Decoder *decoder, const int maxframes)
{
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;

    if (!ctx)
        return;
    else if (!ctx->thread_created)
    {
        Mutex_Lock(ctx->lock);
        if (!ctx->halt && (ctx->videocount >= ctx->maxframes))
            return;  // already maxed out on frames, don't do anything this pump.
        Mutex_Unlock(ctx->lock);

        PumpDecoder(ctx, maxframes);
    } // else if
} // THEORAPLAY_pumpDecode

int THEORAPLAY_isDecoding(THEORAPLAY_Decoder *decoder)
{
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;
    int retval = 0;
    if (ctx)
    {
        Mutex_Lock(ctx->lock);
        retval = ( ctx && (ctx->audiolist || ctx->videolist || !ctx->thread_done) );
        Mutex_Unlock(ctx->lock);
    } // if
    return retval;
} // THEORAPLAY_isDecoding


#define GET_SYNCED_VALUE(typ, defval, decoder, member) \
    TheoraDecoder *ctx = (TheoraDecoder *) decoder; \
    typ retval = defval; \
    if (ctx) { \
        Mutex_Lock(ctx->lock); \
        retval = ctx->member; \
        Mutex_Unlock(ctx->lock); \
    } \
    return retval;

int THEORAPLAY_isInitialized(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(int, 0, decoder, prepped);
} // THEORAPLAY_isInitialized


int THEORAPLAY_hasVideoStream(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(int, 0, decoder, hasvideo);
} // THEORAPLAY_hasVideoStream


int THEORAPLAY_hasAudioStream(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(int, 0, decoder, hasaudio);
} // THEORAPLAY_hasAudioStream


unsigned int THEORAPLAY_availableVideo(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(unsigned int, 0, decoder, videocount);
} // THEORAPLAY_availableVideo


unsigned int THEORAPLAY_availableAudio(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(unsigned int, 0, decoder, audioms);
} // THEORAPLAY_availableAudio


int THEORAPLAY_decodingError(THEORAPLAY_Decoder *decoder)
{
    GET_SYNCED_VALUE(int, 0, decoder, decode_error);
} // THEORAPLAY_decodingError


const THEORAPLAY_AudioPacket *THEORAPLAY_getAudio(THEORAPLAY_Decoder *decoder)
{
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;
    AudioPacket *retval;

    Mutex_Lock(ctx->lock);
    retval = ctx->audiolist;
    if (retval)
    {
        ctx->audioms -= retval->playms;
        ctx->audiolist = retval->next;
        retval->next = NULL;
        if (ctx->audiolist == NULL)
            ctx->audiolisttail = NULL;
    } // if
    Mutex_Unlock(ctx->lock);

    return retval;
} // THEORAPLAY_getAudio


void THEORAPLAY_freeAudio(const THEORAPLAY_AudioPacket *_item)
{
    THEORAPLAY_AudioPacket *item = (THEORAPLAY_AudioPacket *) _item;
    if (item != NULL)
    {
        assert(item->next == NULL);
        free(item->samples);
        free(item);
    } // if
} // THEORAPLAY_freeAudio


const THEORAPLAY_VideoFrame *THEORAPLAY_getVideo(THEORAPLAY_Decoder *decoder)
{
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;
    VideoFrame *retval;

    Mutex_Lock(ctx->lock);
    retval = ctx->videolist;
    if (retval)
    {
        ctx->videolist = retval->next;
        retval->next = NULL;
        if (ctx->videolist == NULL)
            ctx->videolisttail = NULL;
        assert(ctx->videocount > 0);
        ctx->videocount--;
    } // if
    Mutex_Unlock(ctx->lock);

    return retval;
} // THEORAPLAY_getVideo


void THEORAPLAY_freeVideo(const THEORAPLAY_VideoFrame *_item)
{
    THEORAPLAY_VideoFrame *item = (THEORAPLAY_VideoFrame *) _item;
    if (item != NULL)
    {
        assert(item->next == NULL);
        free(item->pixels);
        free(item);
    } // if
} // THEORAPLAY_freeVideo


unsigned int THEORAPLAY_seek(THEORAPLAY_Decoder *decoder, unsigned long mspos)
{
    unsigned int retval;
    TheoraDecoder *ctx = (TheoraDecoder *) decoder;
    Mutex_Lock(ctx->lock);
    ctx->new_seek_position_ms = mspos;
    retval = ++ctx->seek_generation;
    Mutex_Unlock(ctx->lock);
    return retval;
} // THEORAPLAY_seek

// end of theoraplay.c ...

