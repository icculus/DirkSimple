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
    const float yoffset = 16.0f;
    const float yexcursion = 219.0f;
    const float yfactor = 255.0f / yexcursion;
    const float cboffset = 128.0f;
    const float cbexcursion = 224.0f;
    const float croffset = 128.0f;
    const float crexcursion = 224.0f;
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
        const float krfactor = 255.0f * (2.0f * (1.0f - kr)) / crexcursion;
        const float kbfactor = 255.0f * (2.0f * (1.0f - kb)) / cbexcursion;
        const float green_krfactor = kr / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kr)) / crexcursion;
        const float green_kbfactor = kb / ((1.0f - kb) - kr) * 255.0f * (2.0f * (1.0f - kb)) / cbexcursion;
        int posy;

        for (posy = 0; posy < h; posy++)
        {
            int posx, poshalfx;

            posx = 0;
            for (poshalfx = 0; poshalfx < halfw; poshalfx++, posx += 2)
            {
                const float y1 = (((float) py[posx]) - yoffset) * yfactor;
                const float y2 = (((float) py[posx+1]) - yoffset) * yfactor;
                const float pb = (((float) pcb[poshalfx]) - cboffset);
                const float pr = (((float) pcr[poshalfx]) - croffset);
                const float r1 = y1 + (pr * krfactor);
                const float g1 = y1 - ((green_krfactor * pr) + (green_kbfactor * kb));
                const float b1 = y1 + (pb * kbfactor);
                const float r2 = y2 + (pr * krfactor);
                const float g2 = y2 - ((green_krfactor * pr) + (green_kbfactor * kb));
                const float b2 = y2 + (pb * kbfactor);
                THEORAPLAY_CVT_RGB_OUTPUT(r1, g1, b1);
                THEORAPLAY_CVT_RGB_OUTPUT(r2, g2, b2);
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

