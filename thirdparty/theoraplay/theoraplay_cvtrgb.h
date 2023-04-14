/**
 * TheoraPlay; multithreaded Ogg Theora/Ogg Vorbis decoding.
 *
 * Please see the file LICENSE.txt in the source's root directory.
 *
 *  This file written by Ryan C. Gordon.
 */

#if !THEORAPLAY_INTERNAL
#error Do not include this in your app. It is used internally by TheoraPlay.
#endif

/* vzip1q (etc) is an arm64 thing, annoyingly, but you can __builtin_shuffle to get a working vzip.8 opcode on older ARMs. */
#if THEORAPLAY_CVT_RGB_USE_NEON && !defined(__aarch64__)
#  ifndef THEORAPLAY_NEON_ARM64_FALLBACKS
#    define THEORAPLAY_NEON_ARM64_FALLBACKS 1
#    ifdef __clang__
#      define vzip1q_u8(a, b) (__builtin_shufflevector((a), (b), 0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23))
#      define vzip2q_u8(a, b) (__builtin_shufflevector((a), (b), 8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31))
#      define vzip1q_u16(a, b) (__builtin_shufflevector((a), (b), 0, 8, 1, 9, 2, 10, 3, 11))
#      define vzip2q_u16(a, b) (__builtin_shufflevector((a), (b), 4, 12, 5, 13, 6, 14, 7, 15))
#      define vzip1q_s16(a, b) (__builtin_shufflevector((a), (b), 0, 8, 1, 9, 2, 10, 3, 11))
#      define vzip2q_s16(a, b) (__builtin_shufflevector((a), (b), 4, 12, 5, 13, 6, 14, 7, 15))
#    elif defined(__GNUC__)
#      define vzip1q_u8(a, b) (__builtin_shuffle((a), (b), (uint8x16_t) { 0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23 }))
#      define vzip2q_u8(a, b) (__builtin_shuffle((a), (b), (uint8x16_t) { 8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31 }))
#      define vzip1q_u16(a, b) (__builtin_shuffle((a), (b), (uint16x8_t) { 0, 8, 1, 9, 2, 10, 3, 11 }))
#      define vzip2q_u16(a, b) (__builtin_shuffle((a), (b), (uint16x8_t) { 4, 12, 5, 13, 6, 14, 7, 15 }))
#      define vzip1q_s16(a, b) (__builtin_shuffle((a), (b), (uint16x8_t) { 0, 8, 1, 9, 2, 10, 3, 11 }))
#      define vzip2q_s16(a, b) (__builtin_shuffle((a), (b), (uint16x8_t) { 4, 12, 5, 13, 6, 14, 7, 15 }))
#    else  /* just use the older opcode. */
#      define vzip1q_u8(a, b) (vzipq_u8((a), (b))[0])
#      define vzip2q_u8(a, b) (vzipq_u8((a), (b))[1])
#      define vzip1q_u16(a, b) (vzipq_u16((a), (b))[0])
#      define vzip2q_u16(a, b) (vzipq_u16((a), (b))[1])
#      define vzip1q_s16(a, b) (vzipq_u16((a), (b))[0])
#      define vzip2q_s16(a, b) (vzipq_u16((a), (b))[1])
#    endif
#  endif
#endif

static unsigned char *THEORAPLAY_CVT_FNNAME_420(const THEORAPLAY_Allocator *allocator, const th_info *tinfo, const th_ycbcr_buffer ycbcr)
{
    const int w = tinfo->pic_width;
    const int h = tinfo->pic_height;
    const int halfw = w / 2;
    unsigned char *pixels = (unsigned char *) allocator->allocate(allocator, THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, h));

    // http://www.theora.org/doc/Theora.pdf, 1.1 spec,
    //  chapter 4.2 (Y'CbCr -> Y'PbPr -> R'G'B')
    // These constants apparently work for NTSC _and_ PAL/SECAM.
    #define PRECALC_YUVRGB_VALS 1

    #if !PRECALC_YUVRGB_VALS
    const int yexcursion = 219;
    const int cbcrexcursion = 224;
    const int cbcroffset = 128;
    const float kr = 0.299f;
    const float kb = 0.114f;
    #endif

    if (pixels)
    {
        unsigned char *dst = pixels;
        unsigned char *dst2 = dst + THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, 1);
        const int ystride = ycbcr[0].stride;
        const int cbstride = ycbcr[1].stride;
        const unsigned char *py;
        const unsigned char *pcb;
        const unsigned char *pcr;
        int posy;

        #if !PRECALC_YUVRGB_VALS
        const int crstride = ycbcr[2].stride;
        const int FIXED_POINT_BITS = 7;
        const int yoffset = 16;
        const int yfactor = (int) ((255.0f / yexcursion) * (1<<FIXED_POINT_BITS));
        const int krfactor = (int) ((255.0f * (2.0f * (1.0f - kr)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int kbfactor = (int) ((255.0f * (2.0f * (1.0f - kb)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int green_krfactor = (int) ((kr / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kr)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int green_kbfactor = (int) ((kb / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kb)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        #else
        #define FIXED_POINT_BITS 7
        #define cbcroffset 128
        #define yoffset 16
        #define yfactor 149
        #define krfactor 204
        #define kbfactor 258
        #define green_krfactor 104
        #define green_kbfactor 50
        #define crstride cbstride
        assert(ycbcr[1].stride == ycbcr[2].stride);  // otherwise crstride will be wrong!
        #endif

        {
            const int yoff = (tinfo->pic_x & ~1) + ystride * (tinfo->pic_y & ~1);
            const int cboff = (tinfo->pic_x / 2) + (cbstride) * (tinfo->pic_y / 2);
            py = ycbcr[0].data + yoff;
            pcb = ycbcr[1].data + cboff;
            pcr = ycbcr[2].data + cboff;
        }

        for (posy = 0; posy < h; posy += 2)
        {
            int posx = 0;
            int poshalfx = 0;

            #if THEORAPLAY_CVT_RGB_USE_NEON
            while ((halfw - poshalfx) >= 16)
            {
                int16x8_t vcb1, vcr1, vcg1;
                int16x8_t vcb2, vcr2, vcg2;
                {
                    // load from memory, convert u8 to sint32, subtract the offset
                    #define THEORAPLAY_NEON_PREP_COMPONENT(src, voffset, a, b, c, d) { \
                        const uint8x16_t v = vld1q_u8((src)); \
                        { \
                            const int16x8_t vhalf = vreinterpretq_s16_u16(vmovl_u8(vget_low_u8(v))); \
                            a = vsubq_s32(vmovl_s16(vget_low_s16(vhalf)), voffset);  /* convert first 4 values to int32 */ \
                            b = vsubq_s32(vmovl_s16(vget_high_s16(vhalf)), voffset);  /* convert second 4 values to int32 */ \
                        } { \
                            const int16x8_t vhalf = vreinterpretq_s16_u16(vmovl_u8(vget_high_u8(v))); \
                            c = vsubq_s32(vmovl_s16(vget_low_s16(vhalf)), voffset);  /* convert third 4 values to int32 */ \
                            d = vsubq_s32(vmovl_s16(vget_high_s16(vhalf)), voffset);  /* convert fourth 4 values to int32 */ \
                        } \
                    }

                    // factor, downshift, and pack back down to int16x8_t
                    #define THEORAPLAY_NEON_FACTOR_AND_DOWNSHIFT(v1, v2, a, b, c, d, factor, bits) { \
                        v1 = vcombine_s16(vmovn_s32(vshrq_n_s32(vmulq_n_s32(a, factor), bits)), vmovn_s32(vshrq_n_s32(vmulq_n_s32(b, factor), bits))); \
                        v2 = vcombine_s16(vmovn_s32(vshrq_n_s32(vmulq_n_s32(c, factor), bits)), vmovn_s32(vshrq_n_s32(vmulq_n_s32(d, factor), bits))); \
                    }

                    // load, prep, and factor the color components, build out green value, too...
                    {
                        const int32x4_t vcbcroffset = vdupq_n_s32(cbcroffset);
                        int32x4_t ga, gb, gc, gd;

                        // Process Cb...
                        {
                            int32x4_t a, b, c, d;
                            THEORAPLAY_NEON_PREP_COMPONENT(((const uint8_t *) pcb) + poshalfx, vcbcroffset, a, b, c, d);
                            THEORAPLAY_NEON_FACTOR_AND_DOWNSHIFT(vcb1, vcb2, a, b, c, d, kbfactor, FIXED_POINT_BITS);

                            // a, b, c, and d are still valid Cb values, start building out Cg from them.
                            ga = vmulq_n_s32(a, green_kbfactor);
                            gb = vmulq_n_s32(b, green_kbfactor);
                            gc = vmulq_n_s32(c, green_kbfactor);
                            gd = vmulq_n_s32(d, green_kbfactor);
                        }

                        // Process Cr...
                        {
                            int32x4_t a, b, c, d;
                            THEORAPLAY_NEON_PREP_COMPONENT(((const uint8_t *) pcr) + poshalfx, vcbcroffset, a, b, c, d);

                            /* factor the Cr side into our green component and add it to previous work. */
                            ga = vaddq_s32(ga, vmulq_n_s32(a, green_krfactor));
                            gb = vaddq_s32(gb, vmulq_n_s32(b, green_krfactor));
                            gc = vaddq_s32(gc, vmulq_n_s32(c, green_krfactor));
                            gd = vaddq_s32(gd, vmulq_n_s32(d, green_krfactor));

                            /* okay, we've got the green work covered, factor Cr, shift for fixed point conversion, and pack it down. */
                            THEORAPLAY_NEON_FACTOR_AND_DOWNSHIFT(vcr1, vcr2, a, b, c, d, krfactor, FIXED_POINT_BITS);
                        }

                        // Finish off green...
                        vcg1 = vcombine_s16(vmovn_s32(vshrq_n_s32(ga, FIXED_POINT_BITS)), vmovn_s32(vshrq_n_s32(gb, FIXED_POINT_BITS)));
                        vcg2 = vcombine_s16(vmovn_s32(vshrq_n_s32(gc, FIXED_POINT_BITS)), vmovn_s32(vshrq_n_s32(gd, FIXED_POINT_BITS)));
                    }
                }

                // load Y components and build out pixels! We have enough color components to cover _64_ pixels (32 each in two rows).

                /* so the gameplan is some magic with vzipq:
                   we start with 16 pixels, with their components in four separate registers:

                     Ra Rb Rc Rd Re Rf Rg Rh Ri Rj Rk Rl Rm Rn Ro Rp
                     Ga Gb Gc Gd Ge Gf Gg Gh Gi Gj Gk Gl Gm Gn Go Gp
                     Ba Bb Bc Bd Be Bf Bg Bh Bi Bj Bk Bl Bm Bn Bo Bp
                     Aa Ab Ac Ad Ae Af Ag Ah Ai Aj Ak Al Am An Ao Ap  (alpha is always 255, so we just vdup_n_u8 this to a register)

                   ...and vzipq1 the values so they combine across two registers:
                     Ra Ga Rb Gb Rc Gc Rd Gd Re Ge Rf Gf Rg Gg Rh Gh
                     Ba Aa Bb Ab Bc Ac Bd Ad Be Ae Bf Af Bg Ag Bh Ah

                   ...then reinterpret those registers as 16 bit values and vzip _those_:
                     Ra Ga Ba Aa Rb Gb Bb Ab Rc Gc Bc Ac Rd Gd Bd Ad

                   ...and then we have four 32-bit pixels in RGBA8888 order ready to be stored out,
                   and we just have to do this again for the other pixels until all 16 are done. */
                #define THEORAPLAY_NEON_CVT_TO_RGB(dst, src, vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2) { \
                    int16x8_t vy1, vy2; \
                    { \
                        int32x4_t a, b, c, d; \
                        const int32x4_t vyoffset = vdupq_n_s32(yoffset); \
                        THEORAPLAY_NEON_PREP_COMPONENT(src, vyoffset, a, b, c, d); \
                        THEORAPLAY_NEON_FACTOR_AND_DOWNSHIFT(vy1, vy2, a, b, c, d, yfactor, FIXED_POINT_BITS); \
                    } \
                    const uint8x16_t vr = vreinterpretq_u8_s8(vcombine_s8(vmovn_s16(vmaxq_s16(vminq_s16(vaddq_s16(vy1, vcrdup1), vdupq_n_s16(255)), vdupq_n_s16(0))), vmovn_s16(vmaxq_s16(vminq_s16(vaddq_s16(vy2, vcrdup2), vdupq_n_s16(255)), vdupq_n_s16(0))))); \
                    const uint8x16_t vg = vreinterpretq_u8_s8(vcombine_s8(vmovn_s16(vmaxq_s16(vminq_s16(vsubq_s16(vy1, vcgdup1), vdupq_n_s16(255)), vdupq_n_s16(0))), vmovn_s16(vmaxq_s16(vminq_s16(vsubq_s16(vy2, vcgdup2), vdupq_n_s16(255)), vdupq_n_s16(0))))); \
                    const uint8x16_t vb = vreinterpretq_u8_s8(vcombine_s8(vmovn_s16(vmaxq_s16(vminq_s16(vaddq_s16(vy1, vcbdup1), vdupq_n_s16(255)), vdupq_n_s16(0))), vmovn_s16(vmaxq_s16(vminq_s16(vaddq_s16(vy2, vcbdup2), vdupq_n_s16(255)), vdupq_n_s16(0))))); \
                    uint8x16_t vzipa, vzipb; \
                    uint8x16_t vrgba; \
                    vzipa = vzip1q_u8(vr, vg); \
                    vzipb = vzip1q_u8(vb, vdupq_n_u8(255)); \
                    vrgba = vreinterpretq_u8_u16(vzip1q_u16(vreinterpretq_u16_u8(vzipa), vreinterpretq_u16_u8(vzipb))); \
                    THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, vrgba); \
                    vrgba = vreinterpretq_u8_u16(vzip2q_u16(vreinterpretq_u16_u8(vzipa), vreinterpretq_u16_u8(vzipb))); \
                    THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, vrgba); \
                    vzipa = vzip2q_u8(vr, vg); \
                    vzipb = vzip2q_u8(vb, vdupq_n_u8(255)); \
                    vrgba = vreinterpretq_u8_u16(vzip1q_u16(vreinterpretq_u16_u8(vzipa), vreinterpretq_u16_u8(vzipb))); \
                    THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, vrgba); \
                    vrgba = vreinterpretq_u8_u16(vzip2q_u16(vreinterpretq_u16_u8(vzipa), vreinterpretq_u16_u8(vzipb))); \
                    THEORAPLAY_CVT_RGB_OUTPUT_NEON(dst, vrgba); \
                }

                int16x8_t vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2;

                /* duplicate every other element (lower half), since pairs of Y values use the same Cr/Cg/Cb components. */
                vcrdup1 = vzip1q_s16(vcr1, vcr1);
                vcgdup1 = vzip1q_s16(vcg1, vcg1);
                vcbdup1 = vzip1q_s16(vcb1, vcb1);
                vcrdup2 = vzip2q_s16(vcr1, vcr1);
                vcgdup2 = vzip2q_s16(vcg1, vcg1);
                vcbdup2 = vzip2q_s16(vcb1, vcb1);

                /* get 16 Y values from the first row. */
                THEORAPLAY_NEON_CVT_TO_RGB(dst, ((const uint8_t *) py) + posx, vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2);

                /* get 16 Y values from the second row. */
                THEORAPLAY_NEON_CVT_TO_RGB(dst2, ((const uint8_t *) py) + posx + ystride, vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2);

                /* duplicate every other element (upper half), since pairs of Y values use the same Cr/Cg/Cb components. */
                vcrdup1 = vzip1q_s16(vcr2, vcr2);
                vcgdup1 = vzip1q_s16(vcg2, vcg2);
                vcbdup1 = vzip1q_s16(vcb2, vcb2);
                vcrdup2 = vzip2q_s16(vcr2, vcr2);
                vcgdup2 = vzip2q_s16(vcg2, vcg2);
                vcbdup2 = vzip2q_s16(vcb2, vcb2);

                /* get second set of 16 Y values from the first row. */
                THEORAPLAY_NEON_CVT_TO_RGB(dst, ((const uint8_t *) py) + posx + 16, vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2);

                /* get second set of 16 Y values from the second row. */
                THEORAPLAY_NEON_CVT_TO_RGB(dst2, ((const uint8_t *) py) + posx + ystride + 16, vcrdup1, vcgdup1, vcbdup1, vcrdup2, vcgdup2, vcbdup2);

                #undef THEORAPLAY_NEON_PREP_COMPONENT
                #undef THEORAPLAY_NEON_FACTOR_AND_DOWNSHIFT
                #undef THEORAPLAY_NEON_CVT_TO_RGB

                poshalfx += 16;
                posx += 32;
            }
            #endif

            while (poshalfx < halfw)  // finish out with scalar operations.
            {
                const int pb = pcb[poshalfx] - cbcroffset;
                const int pr = pcr[poshalfx] - cbcroffset;
                const int pb_factored = ((pb * kbfactor) >> FIXED_POINT_BITS);
                const int pr_factored = ((pr * krfactor) >> FIXED_POINT_BITS);
                const int pg_factored = (((green_krfactor * pr) + (green_kbfactor * pb)) >> FIXED_POINT_BITS);
                {
                    const int y1 = ((py[posx] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                    const int r1 = y1 + pr_factored;
                    const int g1 = y1 - pg_factored;
                    const int b1 = y1 + pb_factored;
                    THEORAPLAY_CVT_RGB_OUTPUT(dst, r1, g1, b1);
                }
                {
                    const int y2 = ((py[posx+1] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                    const int r2 = y2 + pr_factored;
                    const int g2 = y2 - pg_factored;
                    const int b2 = y2 + pb_factored;
                    THEORAPLAY_CVT_RGB_OUTPUT(dst, r2, g2, b2);
                }
                {
                    const int y3 = ((py[ystride+posx] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                    const int r3 = y3 + pr_factored;
                    const int g3 = y3 - pg_factored;
                    const int b3 = y3 + pb_factored;
                    THEORAPLAY_CVT_RGB_OUTPUT(dst2, r3, g3, b3);
                }
                {
                    const int y4 = ((py[ystride+posx+1] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                    const int r4 = y4 + pr_factored;
                    const int g4 = y4 - pg_factored;
                    const int b4 = y4 + pb_factored;
                    THEORAPLAY_CVT_RGB_OUTPUT(dst2, r4, g4, b4);
                }

                poshalfx++;
                posx += 2;
            } // while

            dst += THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, 1);
            dst2 += THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE(w, 1);

            // adjust to the start of the next line.
            py += ystride * 2;
            pcb += cbstride;
            pcr += crstride;
        } // for
    } // if

    return pixels;
} // THEORAPLAY_CVT_FNNAME_420

#if PRECALC_YUVRGB_VALS
#undef FIXED_POINT_BITS
#undef cbcroffset
#undef yoffset
#undef yfactor
#undef krfactor
#undef kbfactor
#undef green_krfactor
#undef green_kbfactor
#undef crstride
#endif
#undef PRECALC_YUVRGB_VALS

#undef THEORAPLAY_CVT_FNNAME_420

#ifndef THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES
#undef THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE
#undef THEORAPLAY_CVT_RGB_OUTPUT
#else
#undef THEORAPLAY_CVT_RGB_KEEP_SCALAR_DEFINES
#endif

#ifdef THEORAPLAY_CVT_RGB_USE_NEON
#undef THEORAPLAY_CVT_RGB_USE_NEON
#undef THEORAPLAY_CVT_RGB_OUTPUT_NEON
#endif

// end of theoraplay_cvtrgb.h ...

