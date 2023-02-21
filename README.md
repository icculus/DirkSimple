# DirkSimple

## What is this?

This is a dirt-simple FMV/laserdisc game player. It uses the original footage
from the supported games but not their ROMs. The game logic
has been implemented from scratch in Lua.

There are very few options: you point it at an Ogg Theora-encoded video of
the laserdisc contents and that's it.

The goal was to make a simple, portable way to play Dragon's Lair without
a lot of bells and whistles. If you need more features, like actual laserdisc
player support and control of hardware scoreboards, etc, not to mention
support for more FMV games, you should consider checking out [DAPHNE](http://www.daphne-emu.com/) instead.


## How do I use this?

- Get a copy of the Dragon's Lair game footage. You can extract this from a
Digital Leisure DVD, and probably several other legitimate places. If it
works with DAPHNE, it'll likely work here.

- DAPHNE eventually wants a MPEG2 video file with no audio track and a
separate Ogg Vorbis audio file that matches it. You can use
[ffmpeg](https://ffmpeg.org/) to convert those two files into a single Ogg
Theora file that DirkSimple can use. Like this:

  ```bash
  ffmpeg -i lair.m2v -i lair.ogg -codec:v libtheora -qscale:v 7 -codec:a libvorbis -qscale:a 5 -pix_fmt yuv420p lair.ogv
  ```

- If you have the game content split up across multiple files, you can
  (probably) use ffmpeg to concatenate them into a single video file, as long
  as the final contents match up. (if anyone has successfully done this,
  please open an issue with the details!).

- DirkSimple does not care what resolution the final video is, or what
  framerate it runs at, as long as the video timing matches up to the original
  arcade cabinet version.

- Make sure that Ogg Theora file is named "lair.ogv" and you're good to go.

- Build DirkSimple: Make sure you have CMake and SDL2 development libraries
  on your system and run this from the same directory as this README:

  ```bash
  cmake -B cmake-build && cmake --build cmake-build
  ```

  If everything worked out, you will have a "dirksimple" binary in the
  "cmake-build" directory.

- Run `./dirksimple lair.ogv` and enjoy the game.

- If installing somewhere, the "data" directory in the root of this repo
  must be included in the same directory as the binary (or in the proper
  place in a macOS app bundle). You can hardcode a different directory
  (for Linux distros that want this to be in /usr/share/games/DirkSimple,
  separate from the binary, for example), by setting the CMake option
  `-DDIRKSIMPLE_FORCE_BASE_DIR=/usr/share/games/DirkSimple/` ... make sure
  there's a trailing '/' char!


## libretro core!

Ever want to play Dragon's Lair under RetroArch but couldn't figure out how
to make lr-daphne work? Now you can. By default, building DirkSimple will
also generate a libretro core; when used with RetroArch, you can point it
at your lair.ogv and enjoy the RetroArch overlay, controller support,
save states, etc.

Make sure that the `data` directory in the root of this repo is copied to
your RetroArch frontend's system directory, under a directory named
`DirkSimple`.

For example, on my machine's Steam install of RetroArch, this file exists:

    /home/icculus/.local/share/Steam/steamapps/common/RetroArch/system/DirkSimple/data/games/lair/game.lua

The libretro core will not work if these files are missing!


## What about other games?

We now support [Cliff Hanger](https://en.wikipedia.org/wiki/Cliff_Hanger_(video_game))!
Gameplay is near-identical to the original arcade experience. Point the program
at "cliff.ogv" and enjoy!

I would like to add other games tos DirkSimple. For many of
the popular ones, like Space Ace, most of the work is just filling in a table
of scenes, their timings and recognized player actions. For others (like
Cobra Command), it'll take some extensions to this engine that are planned
but not yet started.

If you have access to that information, or would like to take the significant
effort to gather that information, get in touch, please!


