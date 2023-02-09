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
static uint64_t GTicks = 0;         // Current ticks into the game, increases each iteration.
static uint64_t GTicksOffset = 0;   // offset from monotonic clock where we started.
static uint32_t GFrameMS = 0;       // milliseconds each video frame takes.
static int64_t GSeekToTicksOffset = 0;
static uint64_t GClipStartMs = 0;   // Milliseconds into video stream that starts this clip.
static uint64_t GClipStartTicks = 0;  // GTicks when clip started playing
static int GShowingSingleFrame = 0;
static unsigned int GSeekGeneration = 0;
static int GNeedInitialLuaTick = 1;
static const THEORAPLAY_VideoFrame *GPendingVideoFrame = NULL;


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

// !!! FIXME: start_clip and show_single_frame should take a framenum, not timestamp
static void DirkSimple_show_single_frame(uint32_t startms)
{
    if (GDecoder) {
        DirkSimple_log("START SINGLE FRAME: GTicks %u, startms %u\n", (unsigned int) GTicks, (unsigned int) startms);
        GSeekGeneration = THEORAPLAY_seek(GDecoder, startms);
        DirkSimple_cleardiscaudio();
        GClipStartMs = startms;
        GClipStartTicks = 0;
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
        GShowingSingleFrame = 0;
    }
}

static int luahook_DirkSimple_start_clip(lua_State *L)
{
    const uint32_t startms = (uint32_t) lua_tonumber(L, 1);
    DirkSimple_start_clip(startms);
    return 0;
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

// Sets t[sym]=f, where t is on the top of the Lua stack.
static void set_cfunc(lua_State *L, lua_CFunction f, const char *sym)
{
    lua_pushcfunction(L, f);
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
        set_cfunc(GLua, luahook_DirkSimple_log, "log");
        set_cfunc(GLua, luahook_panic, "panic");
        set_cfunc(GLua, luahook_DirkSimple_stackwalk, "stackwalk");
        set_cfunc(GLua, luahook_DirkSimple_debugger, "debugger");
        set_string(GLua, "", "gametitle");
        set_string(GLua, GLuaLicense, "lua_license");  // just so deadcode elimination can't remove this string from the binary.
    lua_setglobal(GLua, DIRKSIMPLE_LUA_NAMESPACE);

    load_lua_gamecode(GLua, GGameDir);

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
    THEORAPLAY_stopDecode(GDecoder);
    GDecoder = NULL;
    GFrameMS = 0;
    GTicks = 0;
    GTicksOffset = 0;
    GSeekToTicksOffset = 0;
    GClipStartMs = 0xFFFFFFFF;
    GShowingSingleFrame = 0;
    GClipStartTicks = 0;
    GSeekGeneration = 0;
    GNeedInitialLuaTick = 1;
    GPreviousInputBits = 0;
    GDiscoveredVideoFormat = 0;
    GDiscoveredAudioFormat = 0;
    GPendingVideoFrame = NULL;
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

void DirkSimple_tick(uint64_t monotonic_ms, uint64_t inputbits)
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
            }
            lua_pop(L, 1);
        }

        GFrameMS = (video->fps == 0.0) ? 0 : ((uint32_t) (1000.0 / video->fps));

        GDiscoveredVideoFormat = 1;
        DirkSimple_log("We are playing '%s'", gametitle);
        DirkSimple_log("Virtual laserdisc video format: %s, %dx%d, %ffps", pixfmtstr(video->format), (int) video->width, video->height, video->fps);
        DirkSimple_videoformat(gametitle, video->width, video->height, video->fps);
        DirkSimple_free(gametitle);
        THEORAPLAY_freeVideo(video);  // dump this, the game is going to seek at startup anyhow.
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
        DirkSimple_log("Virtual laserdisc audio format: float32, %d channels, %dHz", (int) audio->channels, (int) audio->freq);
        DirkSimple_audioformat(audio->channels, audio->freq);
        THEORAPLAY_freeAudio(audio);  // dump this, the game is going to seek at startup anyhow.
    }


    if (GTicksOffset == 0) {
        if (monotonic_ms == 0) {
            return;  // just let this tick up until we aren't zero.
        }
        GTicksOffset = monotonic_ms;
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

    GPreviousInputBits = inputbits;

    // the tick function demanded a seek, don't bother messing with the movie this frame.
    // also doing this after the tick makes sure we don't render any frames past the end
    // of the scene due to latency and process scheduling.
    if (GSeekGeneration != expected_seek_generation) {
//DirkSimple_log("seek was requested
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

// end of dirksimple.c ...

