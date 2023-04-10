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
            int poshalfx;

            for (poshalfx = 0; poshalfx < halfw; poshalfx++, posx += 2)
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
            } // for

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
#undef THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE
#undef THEORAPLAY_CVT_RGB_OUTPUT

// end of theoraplay_cvtrgb.h ...

