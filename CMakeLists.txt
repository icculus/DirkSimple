# DirkSimple; a dirt-simple player for FMV games.
#
# Please see the file LICENSE.txt in the source's root directory.
#
# This file written by Ryan C. Gordon.

project(DirkSimple)
cmake_minimum_required(VERSION 3.0.0)

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    set(ANDROID TRUE)
endif()

include(CheckLibraryExists)

CHECK_LIBRARY_EXISTS(m floor "" HAVE_LIB_M)

set(DIRKSIMPLE_SDL_DEFAULT ON)
set(DIRKSIMPLE_LIBRETRO_DEFAULT ON)

if(CMAKE_SYSTEM_NAME STREQUAL "Emscripten")
  set(EMSCRIPTEN TRUE)
  set(IPO_SUPPORTED YES)  # !!! FIXME: -flto=thin currently broken in Emscripten: https://github.com/emscripten-core/emscripten/issues/12763
  set(IPO_FLAG "-flto")
  add_definitions("${IPO_FLAG}")  # Force every compile to the thing Emscripten currently supports.
endif()

# Building as part of RetroArch? Turn off everything but the libretro plugin by default.
if(LIBRETRO)
    set(DIRKSIMPLE_SDL_DEFAULT OFF)
endif()

# Rather than build the static libraries twice so we can have them built with
# `-fPIC` for linking into the libretro shared library, just always build them
# that way. It's fine. See the `POSITION_INDEPENDENT_CODE` lines below.

option(DIRKSIMPLE_SDL "Build the DirkSimple SDL app" ${DIRKSIMPLE_SDL_DEFAULT})
option(DIRKSIMPLE_LIBRETRO "Build the DirkSimple libretro core" ${DIRKSIMPLE_LIBRETRO_DEFAULT})
set(DIRKSIMPLE_FORCE_BASE_DIR "" CACHE STRING "Force the base dir to a hardcoded path, like '/usr/share/games/DirkSimple'")

if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
else()  # This assumes you have GCC or Clang at the moment.
    add_definitions(-Wall)
    if(NOT EMSCRIPTEN)
        set(USE_PTHREAD TRUE)
    endif()
endif()

add_library(dirksimple-ogg STATIC
	thirdparty/libogg/src/bitwise.c
	thirdparty/libogg/src/framing.c
)
set_target_properties(dirksimple-ogg PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(dirksimple-ogg PRIVATE
    thirdparty/libogg/include
)

add_library(dirksimple-vorbis STATIC
    thirdparty/libvorbis/lib/analysis.c
    thirdparty/libvorbis/lib/bitrate.c
    thirdparty/libvorbis/lib/block.c
    thirdparty/libvorbis/lib/codebook.c
    thirdparty/libvorbis/lib/envelope.c
    thirdparty/libvorbis/lib/floor0.c
    thirdparty/libvorbis/lib/floor1.c
    thirdparty/libvorbis/lib/info.c
    thirdparty/libvorbis/lib/lpc.c
    thirdparty/libvorbis/lib/lsp.c
    thirdparty/libvorbis/lib/mapping0.c
    thirdparty/libvorbis/lib/mdct.c
    thirdparty/libvorbis/lib/psy.c
    thirdparty/libvorbis/lib/registry.c
    thirdparty/libvorbis/lib/res0.c
    thirdparty/libvorbis/lib/sharedbook.c
    thirdparty/libvorbis/lib/smallft.c
    thirdparty/libvorbis/lib/synthesis.c
    thirdparty/libvorbis/lib/vorbisenc.c
    thirdparty/libvorbis/lib/vorbisfile.c
    thirdparty/libvorbis/lib/window.c
)
set_target_properties(dirksimple-vorbis PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(dirksimple-vorbis PRIVATE
    thirdparty/libogg/include
    thirdparty/libvorbis/include
    thirdparty/libvorbis/lib
)

add_library(dirksimple-theora STATIC
    thirdparty/libtheora/lib/apiwrapper.c
    thirdparty/libtheora/lib/bitpack.c
    thirdparty/libtheora/lib/decapiwrapper.c
    thirdparty/libtheora/lib/decinfo.c
    thirdparty/libtheora/lib/decode.c
    thirdparty/libtheora/lib/dequant.c
    thirdparty/libtheora/lib/fragment.c
    thirdparty/libtheora/lib/huffdec.c
    thirdparty/libtheora/lib/idct.c
    thirdparty/libtheora/lib/info.c
    thirdparty/libtheora/lib/internal.c
    thirdparty/libtheora/lib/quant.c
    thirdparty/libtheora/lib/state.c
)
set_target_properties(dirksimple-theora PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(dirksimple-theora PRIVATE
    thirdparty/libogg/include
    thirdparty/libtheora/include
)

add_library(dirksimple-theoraplay STATIC
    thirdparty/theoraplay/theoraplay.c
)
set_target_properties(dirksimple-theoraplay PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(dirksimple-theoraplay PRIVATE
    thirdparty/libogg/include
    thirdparty/libvorbis/include
    thirdparty/libtheora/include
)
target_compile_definitions(dirksimple-theoraplay PRIVATE "-DTHEORAPLAY_NO_MALLOC_FALLBACK=1")
target_compile_definitions(dirksimple-theoraplay PRIVATE "-DTHEORAPLAY_NO_FOPEN_FALLBACK=1")

add_library(dirksimple-lua STATIC
    thirdparty/lua/src/lapi.c
    thirdparty/lua/src/ldebug.c
    thirdparty/lua/src/ldo.c
    thirdparty/lua/src/ldump.c
    thirdparty/lua/src/lfunc.c
    thirdparty/lua/src/lgc.c
    thirdparty/lua/src/lmem.c
    thirdparty/lua/src/lobject.c
    thirdparty/lua/src/lopcodes.c
    thirdparty/lua/src/lstate.c
    thirdparty/lua/src/lstring.c
    thirdparty/lua/src/ltable.c
    thirdparty/lua/src/ltm.c
    thirdparty/lua/src/lundump.c
    thirdparty/lua/src/lvm.c
    thirdparty/lua/src/lzio.c
    thirdparty/lua/src/lauxlib.c
    thirdparty/lua/src/lbaselib.c
    thirdparty/lua/src/lstrlib.c
    thirdparty/lua/src/ltablib.c
    thirdparty/lua/src/lctype.c
    thirdparty/lua/src/lparser.c
    thirdparty/lua/src/llex.c
    thirdparty/lua/src/lcode.c
    thirdparty/lua/src/linit.c
    thirdparty/lua/src/lctype.c
    thirdparty/lua/src/ldblib.c
    thirdparty/lua/src/liolib.c
    thirdparty/lua/src/lmathlib.c
    thirdparty/lua/src/loslib.c
    thirdparty/lua/src/lcorolib.c
    thirdparty/lua/src/loadlib.c
)
set_target_properties(dirksimple-lua PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_compile_definitions(dirksimple-lua PRIVATE "-DLUA_USE_MKSTEMP=1")  # as opposed to tmpnam(), yuck!
target_compile_definitions(dirksimple-lua PRIVATE "-DLUA_USE_ULONGJMP=1")

if(DIRKSIMPLE_SDL)
    find_package(SDL2 REQUIRED)
    add_executable(dirksimple dirksimple.c dirksimple_sdl.c)
    target_include_directories(dirksimple PRIVATE
        ${SDL2_INCLUDE_DIRS} ${SDL2_INCLUDE_DIR}
        thirdparty/lua/src
        thirdparty/theoraplay
    )
    target_link_libraries(dirksimple ${SDL2_LIBRARIES} ${SDL2_LIBRARY})
    target_link_libraries(dirksimple dirksimple-theoraplay dirksimple-theora dirksimple-vorbis dirksimple-ogg dirksimple-lua)
    if(USE_PTHREAD)
        target_link_libraries(dirksimple pthread)
    endif()
    if(HAVE_LIB_M)
        target_link_libraries(dirksimple m)
    endif()
    if(EMSCRIPTEN)
        set_target_properties(dirksimple PROPERTIES OUTPUT_NAME "dirksimple-wasm")
        set_target_properties(dirksimple PROPERTIES LINK_FLAGS "${IPO_FLAG} -s WASM=1 -s ALLOW_MEMORY_GROWTH=1 -s ASSERTIONS=0 -s EXPORTED_RUNTIME_METHODS=['addRunDependency','removeRunDependency'] -s DEFAULT_LIBRARY_FUNCS_TO_INCLUDE=['$autoResumeAudioContext','$dynCall']")
    endif()

    if(NOT DIRKSIMPLE_FORCE_BASE_DIR STREQUAL "")
        set_target_properties(dirksimple PROPERTIES COMPILE_DEFINITIONS "DIRKSIMPLE_FORCE_BASE_DIR=${DIRKSIMPLE_FORCE_BASE_DIR}")
    endif()

   add_custom_command(
       TARGET dirksimple POST_BUILD
       COMMAND ${CMAKE_COMMAND} ARGS -E create_symlink "${CMAKE_CURRENT_SOURCE_DIR}/data" "${CMAKE_CURRENT_BINARY_DIR}/data"
   )

   if(APPLE)
       add_custom_command(
           TARGET dirksimple POST_BUILD
           COMMAND ${CMAKE_COMMAND} ARGS -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app"
           COMMAND ${CMAKE_COMMAND} ARGS -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents"
           COMMAND ${CMAKE_COMMAND} ARGS -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/MacOS"
           COMMAND ${CMAKE_COMMAND} ARGS -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/Resources"
           COMMAND ${CMAKE_COMMAND} ARGS -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/data" "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/Resources/data"
           COMMAND ${CMAKE_COMMAND} ARGS -E copy "${CMAKE_CURRENT_BINARY_DIR}/dirksimple" "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/MacOS/dirksimple"
           COMMAND ${CMAKE_COMMAND} ARGS -E copy "${CMAKE_CURRENT_SOURCE_DIR}/mac-appbundle-info.plist" "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/Info.plist"
           COMMAND ${CMAKE_COMMAND} ARGS -E copy "${CMAKE_CURRENT_SOURCE_DIR}/icon.icns" "${CMAKE_CURRENT_BINARY_DIR}/DirkSimple.app/Contents/Resources/DirkSimple.icns"
       )
   endif()
endif()

if(DIRKSIMPLE_LIBRETRO)
    add_library(dirksimple_libretro SHARED dirksimple.c dirksimple_libretro.c)
    target_include_directories(dirksimple_libretro PRIVATE
        thirdparty/lua/src
        thirdparty/theoraplay
    )
    set_target_properties(dirksimple_libretro PROPERTIES PREFIX "")
    target_link_libraries(dirksimple_libretro dirksimple-theoraplay dirksimple-theora dirksimple-vorbis dirksimple-ogg dirksimple-lua)

    if(USE_PTHREAD)
        target_link_libraries(dirksimple_libretro pthread)
    endif()

    if(HAVE_LIB_M)
        target_link_libraries(dirksimple_libretro m)
    endif()
    if(ANDROID)  # Android builds of libretro cores need specific names.
        set_target_properties(dirksimple_libretro PROPERTIES LIBRARY_OUTPUT_NAME dirksimple_libretro_android)
    endif()
    if(NOT DIRKSIMPLE_FORCE_BASE_DIR STREQUAL "")
        set_target_properties(dirksimple_libretro PROPERTIES COMPILE_DEFINITIONS "DIRKSIMPLE_FORCE_BASE_DIR=${DIRKSIMPLE_FORCE_BASE_DIR}")
    endif()
endif()

# end of CMakeLists.txt ...

