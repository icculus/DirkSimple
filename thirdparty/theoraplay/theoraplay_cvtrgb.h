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
    const int yexcursion = 219;
    const int cbcrexcursion = 224;
    const int cbcroffset = 128;
    const float kr = 0.299f;
    const float kb = 0.114f;

    if (pixels)
    {
        unsigned char *dst = pixels;
        const int ystride = ycbcr[0].stride;
        const int cbstride = ycbcr[1].stride;
        const int crstride = ycbcr[2].stride;
        const int yoff = (tinfo->pic_x & ~1) + ystride * (tinfo->pic_y & ~1);
        const int cboff = (tinfo->pic_x / 2) + (cbstride) * (tinfo->pic_y / 2);
        const unsigned char *py = ycbcr[0].data + yoff;
        const unsigned char *pcb = ycbcr[1].data + cboff;
        const unsigned char *pcr = ycbcr[2].data + cboff;

        const int FIXED_POINT_BITS = 7;
        const int yoffset = 16;
        const int yfactor = (int) ((255.0f / yexcursion) * (1<<FIXED_POINT_BITS));
        const int krfactor = (int) ((255.0f * (2.0f * (1.0f - kr)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int kbfactor = (int) ((255.0f * (2.0f * (1.0f - kb)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int green_krfactor = (int) ((kr / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kr)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        const int green_kbfactor = (int) ((kb / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kb)) / cbcrexcursion) * (1<<FIXED_POINT_BITS));
        int posy;

        for (posy = 0; posy < h; posy++)
        {
            int posx, poshalfx;

            posx = 0;
            for (poshalfx = 0; poshalfx < halfw; poshalfx++, posx += 2)
            {
                const int y1 = ((py[posx] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                const int y2 = ((py[posx+1] - yoffset) * yfactor) >> FIXED_POINT_BITS;
                const int pb = pcb[poshalfx] - cbcroffset;
                const int pr = pcr[poshalfx] - cbcroffset;

#if 0  /* !!! FIXME: weirdly, this is _slower_ than calculating the same thing multiple times in the #else block. */
                const int pb_factored = ((pb * kbfactor) >> FIXED_POINT_BITS);
                const int pr_factored = ((pr * krfactor) >> FIXED_POINT_BITS);
                const int pg_factored = (((green_krfactor * pr) + (green_kbfactor * pb)) >> FIXED_POINT_BITS);
                const int r1 = y1 + pr_factored;
                const int g1 = y1 - pg_factored;
                const int b1 = y1 + pb_factored;
                THEORAPLAY_CVT_RGB_OUTPUT(r1, g1, b1);
                const int r2 = y2 + pr_factored;
                const int g2 = y2 - pg_factored;
                const int b2 = y2 + pb_factored;
                THEORAPLAY_CVT_RGB_OUTPUT(r2, g2, b2);
#else
                const int r1 = y1 + ((pr * krfactor) >> FIXED_POINT_BITS);
                const int g1 = y1 - (((green_krfactor * pr) + (green_kbfactor * pb)) >> FIXED_POINT_BITS);
                const int b1 = y1 + ((pb * kbfactor) >> FIXED_POINT_BITS);
                const int r2 = y2 + ((pr * krfactor) >> FIXED_POINT_BITS);
                const int g2 = y2 - (((green_krfactor * pr) + (green_kbfactor * pb)) >> FIXED_POINT_BITS);
                const int b2 = y2 + ((pb * kbfactor) >> FIXED_POINT_BITS);
                THEORAPLAY_CVT_RGB_OUTPUT(r1, g1, b1);
                THEORAPLAY_CVT_RGB_OUTPUT(r2, g2, b2);
#endif
            } // for

            // adjust to the start of the next line.
            py += ystride;
            pcb += cbstride * (posy % 2);
            pcr += crstride * (posy % 2);
        } // for
    } // if

    return pixels;
} // THEORAPLAY_CVT_FNNAME_420

#undef THEORAPLAY_CVT_FNNAME_420
#undef THEORAPLAY_CVT_RGB_DST_BUFFER_SIZE
#undef THEORAPLAY_CVT_RGB_OUTPUT

// end of theoraplay_cvtrgb.h ...

