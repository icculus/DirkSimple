-- Dirk Simple; a player for FMV games.
--
-- Please see the file LICENSE.txt in the source's root directory.
--
--  This file written by Ryan C. Gordon.
--

print = DirkSimple.log

-- This is handy for debugging.
function DirkSimple.dumptable(tabname, tab, depth)
    if depth == nil then  -- first call, before any recursion?
        depth = 1
    end

    if tabname ~= nil then
        if tab == nil then
            print(tabname .. " = nil")
            return
        else
            print(tabname .. " = {")
        end
    end

    local depthstr = ""
    for i=1,(depth*4) do
        depthstr = depthstr .. " "
    end

    if tab.DIRKSIMPLE_DUMPTABLE_ITERATED then
        print(depthstr .. "(...circular reference...)")
    else
        tab.DIRKSIMPLE_DUMPTABLE_ITERATED = true
        for k,v in pairs(tab) do
            if type(v) == "table" then
                print(depthstr .. tostring(k) .. " = {")
                DirkSimple.dumptable(nil, v, depth + 1)
                print(depthstr .. "}")
            else
                if k ~= "DIRKSIMPLE_DUMPTABLE_ITERATED" then
                    print(depthstr .. tostring(k) .. " = " .. tostring(v))
                end
            end
        end
        tab.DIRKSIMPLE_DUMPTABLE_ITERATED = nil
    end

    if tabname ~= nil then
        print("}")
    end
end



DirkSimple.gametitle = "Dragon's Lair"

-- SOME GAME CONFIG STUFF
local starting_lives = 3


-- SOME INITIAL SETUP STUFF
local standard_tick = nil   -- gets set up later in this file.
local scenes = nil  -- gets set up later in the file.
local test_scene_name = nil  -- set to name of scene to test. nil otherwise!
--test_scene_name = "tentacle_room"


-- GAME STATE

local lives_left = 0
local current_score = 0
local current_scene = nil
local current_scene_name = nil
local current_scene_is_reversed = false
local current_sequence = nil
local current_ticks = 0
local current_sequence_ticks = 0
local current_sequence_tick_offset = 0
local accepted_input = nil
local scene_manager = nil

-- FUNCTIONS

local function laserdisc_frame_to_ms(frame)
    return ((frame / 23.976) * 1000.0)
end

local function time_laserdisc_frame(frame)
    -- 6297 is the magic millsecond offset between the ROM test screens and the actual game content, I think,
    --  When the ROM would ask for a frame, we have to adjust by this number.
    --  Since we're filling in the timings from the original ROM's data table,
    --  we make this adjustment ourselves.
    return laserdisc_frame_to_ms(frame) - 6297.0
end

local function time_laserdisc_noseek()
    return -1
end

local function time_to_ms(seconds, ms)
    return (seconds * 1000) + ms
end

local function start_sequence(sequencename)
    DirkSimple.log("Starting sequence '" .. sequencename .. "'")
    current_sequence = current_scene[sequencename]
    accepted_input = nil

    local start_time = current_sequence.start_time
    if current_scene_is_reversed then
        start_time = current_sequence.reversed_start_time
    end

    if start_time < 0 then  -- if negative, no seek desired (just keep playing from current location)
        current_sequence_tick_offset = current_sequence_tick_offset + current_sequence_ticks
    else
        -- will suspend ticking until the seek completes and reset sequence tick count
        if current_sequence.is_single_frame then
            DirkSimple.show_single_frame(start_time)
        else
            DirkSimple.start_clip(start_time)
        end
        current_sequence_tick_offset = 0
    end
end

local function start_scene(scenename, is_resurrection)
    DirkSimple.log("Starting scene '" .. scenename .. "'")

    local sequencename
    if is_resurrection then
        sequencename = "start_dead"
    else
        sequencename = "start_alive"
    end

    current_scene_name = scenename
    current_scene = scenes[scenename]

    current_scene_is_reversed = current_scene.reverse_of ~= nil
    if current_scene_is_reversed then
        current_scene = scenes[current_scene.reverse_of]
    end
    start_sequence(sequencename)
end

local function start_attract_mode(after_game_over)
    start_scene('attract_mode', after_game_over)
end

local function game_over(won)
    DirkSimple.log("Game over!")
    if (current_scene ~= nil) and (current_scene.game_over ~= nil) then
        start_sequence(current_scene.game_over)
    else
        start_attract_mode(true)
    end
end

local function choose_next_scene(is_resurrection)
    -- this is obviously going to get more complex later.

    if test_scene_name ~= nil then
        lives_left = 99
        start_scene(test_scene_name, is_resurrection)
        return
    end

    -- intro must be played first.
    --  (!!! FIXME: if we add back in the drawbridge, do we want this to
    --  require it be _completed_ first?
    if scene_manager["introduction"] == 0 then
        start_scene("introduction", is_resurrection)
        return
    end

    local eligible = {}
    for name,completed in pairs(scene_manager) do
        if completed == 0 and name ~= current_scene_name then
            eligible[#eligible+1] = name
        end
    end

    if #eligible == 0 then   -- have we completed all the scenes?
        game_over(true)
    else
        start_scene(eligible[(current_ticks % #eligible) + 1], is_resurrection)
    end
end

local function setup_scene_manager()
    -- this is obviously going to get more complex later.
    scene_manager = {}
    for name,scene in pairs(scenes) do
        if name ~= 'attract_mode' then  -- don't put attract mode in the game's scene list.
           scene_manager[name] = 0
        end
    end
end

local function start_game()
    DirkSimple.log("Start game!")
    lives_left = starting_lives
    current_score = 0
    setup_scene_manager()
    choose_next_scene(false)
end

local function kill_player()
    if lives_left > 0 then
        lives_left = lives_left - 1
    end
    DirkSimple.log("Killing player (lives now left=" .. lives_left .. ")")
    if lives_left == 0 then
        game_over(false)
    else
        choose_next_scene(true)
    end
end

local function check_actions(inputs)
    if accepted_input ~= nil then
        return true  -- ignore all input until end of sequence.
    end


    local actions = current_sequence.actions
    if current_scene_is_reversed and current_sequence.reversed_actions ~= nil then
        actions = current_sequence.reversed_actions
    end

    if actions ~= nil then
        for i,v in ipairs(actions) do
            -- ignore if not in the time window for this input.
            if (current_sequence_ticks >= v.from) and (current_sequence_ticks <= v.to) then
                local input = v.input
                if current_scene_is_reversed then
                    if input == "left" then
                        input = "right"
                    elseif input == "right" then
                        input = "left"
                    end
                end
                if inputs.pressed[input] then  -- we got one!
                    DirkSimple.log("accepted action '" .. input .. "' at " .. tostring(current_sequence_ticks / 1000.0))
                    accepted_input = v
                    return true
                end
            end
        end
        -- !!! FIXME: make buzzing sound to signify input wasn't accepted?
    end

    return false
end

local function check_timeout()
    local done_with_sequence = false
    if current_sequence_ticks >= current_sequence.timeout.when then  -- whole sequence has run to completion.
        done_with_sequence = true
    elseif (accepted_input ~= nil) and accepted_input.interrupt ~= nil then  -- If interrupting, forego the timeout.
        done_with_sequence = true
    end

    if not done_with_sequence then
        return  -- sequence is not complete yet.
    end

    DirkSimple.log("Done with current sequence")

    local outcome
    if accepted_input ~= nil then
        outcome = accepted_input
    else
        outcome = current_sequence.timeout
    end

    if outcome.points ~= nil then
        current_score = current_score + outcome.points
    end

    if outcome.interrupt ~= nil then
        outcome.interrupt()
    elseif outcome.nextsequence ~= nil then  -- end of scene?
        start_sequence(outcome.nextsequence)
    else
        if current_sequence.kills_player then
            kill_player()  -- will update state, start new scene.
        else
            scene_manager[current_scene_name] = scene_manager[current_scene_name] + 1
            choose_next_scene(false)
        end
    end

    -- as a special hack, if the new sequence has a timeout of 0, we process it immediately without
    -- waiting for the next tick, since it's just trying to set up some state before an actual
    -- sequence and we don't want the video to move ahead in a completed sequence or progress
    -- before the actual sequence is ticking.
    if current_sequence.timeout.when == 0 then
        check_timeout()
    end
end

standard_tick = function(ticks, sequenceticks, inputs)
    current_ticks = ticks
    current_sequence_ticks = sequenceticks - current_sequence_tick_offset
    --DirkSimple.log("LUA TICK(ticks=" .. tostring(current_ticks) .. ", sequenceticks=" .. tostring(current_sequence_ticks) .. ")")
    if current_sequence == nil then
        start_attract_mode(false)
    end
    check_actions(inputs)   -- check inputs before timeout, in case an input came through at the last possible moment, even if we're over time.
    check_timeout()
end

-- Start with standard_tick, but other things might override it later.
DirkSimple.tick = standard_tick



-- The scene table!
-- http://www.dragons-lair-project.com/games/related/sequence.asp
scenes = {
    attract_mode = {
        start_alive = {
            timeout = { when=0, nextsequence="attract_movie" },
            start_time = time_laserdisc_noseek(),
        },
        start_dead = {
            start_time = time_to_ms(5, 830),
            is_single_frame = true,
            timeout = { when=time_to_ms(3, 0), nextsequence="attract_movie" },
        },
        attract_movie = {
            start_time = time_to_ms(7, 0),
            timeout = { when=time_to_ms(43, 0), nextsequence="insert_coins" },
            actions = {
                -- Player hit start to start the game
                { input="start", from=time_to_ms(0, 0), to=time_to_ms(60, 0, 0), interrupt=start_game, nextsequence=nil },
            }
        },
        insert_coins = {
            start_time = time_to_ms(6, 200),
            is_single_frame = true,
            timeout = { when=time_to_ms(5, 0), nextsequence="attract_movie" },
            actions = {
                -- Player hit start to start the game
                { input="start", from=time_to_ms(0, 0), to=time_to_ms(60, 0, 0), interrupt=start_game, nextsequence=nil },
            }
        },
    },

    -- Intro level, no gameplay in the arcade version.
    introduction = {
        start_dead = {
            start_time = time_laserdisc_frame(1367),
            timeout = { when=time_to_ms(2, 32), nextsequence="castle_exterior" }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="castle_exterior" }
        },

        castle_exterior = {  -- exterior shot of the castle
            start_time = time_laserdisc_frame(1424),
            timeout = { when=time_to_ms(5, 767), nextsequence="exit_room" },
        },

        -- this skips the drawbridge itself, like the arcade does.
        exit_room = {  -- player runs through the gates.
            start_time = time_laserdisc_frame(1823) - laserdisc_frame_to_ms(2),
            timeout = { when=time_to_ms(2, 359) + laserdisc_frame_to_ms(10), nextsequence=nil },
        },
    },

    -- Swinging ropes, burning over a fiery pit.
    flaming_ropes = {
        start_dead = {
            start_time = time_laserdisc_frame(3505),
            reversed_start_time = time_laserdisc_frame(12669),
            timeout = { when=time_to_ms(2, 228), nextsequence="enter_room" }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(3561),
            reversed_start_time = time_laserdisc_frame(12725),
            timeout = { when=time_to_ms(2, 228), nextsequence="platform_sliding" },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(1, 245), nextsequence="fall_to_death" },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(1, 245), to=time_to_ms(2, 130), nextsequence="rope1", points=251 },
                -- Player grabs rope too late
                { input="right", from=time_to_ms(2, 130), to=time_to_ms(4, 260), nextsequence="fall_to_death" },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(2, 490), nextsequence="fall_to_death" },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(2, 490), nextsequence="fall_to_death" },
            }
        },

        platform_sliding = {  -- Player hesitated, platform starts pulling back
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 621), nextsequence="fall_to_death" },  -- player hesitated, platform is gone, player falls
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(1, 835), to=time_to_ms(2, 884), nextsequence="rope1", points=251 },
                -- Player tries to flee
                { input="left", from=time_to_ms(1, 835), to=time_to_ms(2, 884), nextsequence="fall_to_death" },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(2, 884), nextsequence="fall_to_death" },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(2, 884), nextsequence="fall_to_death" },
            }
        },

        rope1 = {  -- player grabbed first rope
            start_time = time_laserdisc_frame(3693),
            reversed_start_time = time_laserdisc_frame(12857),
            timeout = { when=time_to_ms(2, 228), nextsequence="burns_hands" },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(1, 81), nextsequence="fall_to_death" },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(1, 81), to=time_to_ms(1, 835), nextsequence="rope2", points=379 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
            }
        },

        rope2 = {  -- player grabbed second rope
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 228), nextsequence="burns_hands" },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(1, 81), nextsequence="fall_to_death" },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(1, 81), to=time_to_ms(1, 835), nextsequence="rope3", points=495 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death"  },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="fall_to_death" },
            }
        },

        rope3 = {  -- player grabbed third rope
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 507), nextsequence="misses_landing" },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(0, 852), nextsequence="fall_to_death" },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 852), to=time_to_ms(1, 704), nextsequence="exit_room", points=915 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(1, 769), nextsequence="fall_to_death" },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 769), nextsequence="fall_to_death" },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(1, 769), nextsequence="fall_to_death" },
            }
        },

        exit_room = {  -- player reaches exit platform
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 49), nextsequence=nil },
        },

        misses_landing = {  -- player landed on exit platform, but fell backwards
            start_time = time_laserdisc_frame(3879),
            reversed_start_time = time_laserdisc_frame(13041),
            kills_player = true,
            timeout = { when=time_to_ms(1, 540), nextsequence=nil },
        },

        burns_hands = {  -- rope burns up to hands, making player fall
            start_time = time_laserdisc_frame(3925),
            reversed_start_time = time_laserdisc_frame(13089),
            timeout = { when=time_to_ms(1, 475), nextsequence="fall_to_death" }
        },

        fall_to_death = {  -- player falls into the flames
            start_time = time_laserdisc_frame(3963),
            reversed_start_time = time_laserdisc_frame(13127),
            kills_player = true,
            timeout = { when=time_to_ms(1, 180), nextsequence=nil }
        }
    },

    -- Swinging ropes, burning over a fiery pit (reversed)
    flaming_ropes_reversed = {
        reverse_of = "flaming_ropes"
    },

    -- Bedroom where brick wall appears in front of you to be jumped through.
    bower = {
        start_dead = {
            start_time = time_laserdisc_frame(9093),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(9181) - laserdisc_frame_to_ms(15),
            timeout = { when=time_to_ms(1, 147) + laserdisc_frame_to_ms(15), nextsequence="trapped_in_wall" },
            actions = {
                -- Player jumps through the hole in the wall
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(1, 409) + laserdisc_frame_to_ms(15), nextsequence="exit_room", points=379 },
            }
        },

        trapped_in_wall = {  -- player fails to climb through.
            start_time = time_laserdisc_frame(9301) - laserdisc_frame_to_ms(15),
            kills_player = true,
            timeout = { when=time_to_ms(0, 492) + laserdisc_frame_to_ms(30), nextsequence=nil }
        },

        exit_room = {  -- player reaches the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 425) + laserdisc_frame_to_ms(15), nextsequence=nil },
        },
    },

    -- Room with the "DRINK ME" sign.
    alice_room = {
        start_dead = {
            start_time = time_laserdisc_frame(18226),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(18282) + laserdisc_frame_to_ms(1),
            timeout = { when=time_to_ms(2, 64) - laserdisc_frame_to_ms(1), nextsequence="burned_to_death" },
            actions = {
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(2, 64), nextsequence="exit_room", points=379 },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(2, 64), nextsequence="drinks_potion" },
                { input="down", from=time_to_ms(1, 131), to=time_to_ms(2, 32), nextsequence="burned_to_death" },
                { input="left", from=time_to_ms(1, 131), to=time_to_ms(2, 32), nextsequence="burned_to_death" },
            }
        },

        drinks_potion = {  -- player drinks potion, dies
            start_time = time_laserdisc_frame(18378),
            kills_player = true,
            timeout = { when=time_to_ms(4, 194), nextsequence=nil }
        },

        burned_to_death = {  -- player dies in a fire
            start_time = time_laserdisc_frame(18486),
            kills_player = true,
            timeout = { when=time_to_ms(1, 180), nextsequence=nil }
        },

        exit_room = {  -- player reaches the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 442) + laserdisc_frame_to_ms(12), nextsequence=nil },
        },
    },

    -- Room with the wind blowing you and a diamond you shouldn't reach for.
    wind_room = {
        start_dead = {
            start_time = time_laserdisc_frame(8653),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(8709),
            timeout = { when=time_to_ms(8, 159), nextsequence="sucked_in" },
            actions = {
                { input="right", from=time_to_ms(7, 406), to=time_to_ms(8, 126), nextsequence="exit_room", points=379 },
                { input="up", from=time_to_ms(5, 964), to=time_to_ms(8, 126), nextsequence="sucked_in" },
            }
        },

        sucked_in = {  -- player sucked into hole, falls to death
            start_time = time_laserdisc_frame(8938),
            kills_player = true,
            timeout = { when=time_to_ms(2, 621), nextsequence=nil }
        },

        exit_room = {  -- player reaches the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 459), nextsequence=nil },
        },
    },

    -- Room that crumbles on three sides and then the ceiling caves in
    vestibule = {
        start_dead = {
            start_time = time_laserdisc_frame(4083),
            timeout = { when=time_to_ms(1, 966), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(1887),
            timeout = { when=time_to_ms(3, 998), nextsequence="fell_to_death" },
            actions = {
                { input="right", from=time_to_ms(1, 966), to=time_to_ms(3, 998), nextsequence="stagger", points=251 },
                { input="down", from=time_to_ms(1, 966), to=time_to_ms(3, 998), nextsequence="stagger", points=251 },
                { input="up", from=time_to_ms(1, 966), to=time_to_ms(3, 998), nextsequence="fell_to_death" },
                { input="left", from=time_to_ms(2, 490), to=time_to_ms(3, 965), nextsequence="fell_to_death" },
            }
        },

        stagger = {  -- player staggers in the rumble, room is about to collapse
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 668), nextsequence="fell_to_death" },
            actions = {
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(0, 950), nextsequence="exit_room", points=251 },
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(0, 950), nextsequence="fell_to_death" },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(0, 950), nextsequence="fell_to_death" },
            }
        },

        fell_to_death = {  -- player fell through floor.
            start_time = time_laserdisc_frame(2085),
            kills_player = true,
            timeout = { when=time_to_ms(1, 638), nextsequence=nil }
        },

        exit_room = {  -- player reaches the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 409), nextsequence=nil },
        }
    },

    -- the one with three chances to jump.
    falling_platform_short = {
        start_dead = {
            start_time = time_laserdisc_frame(14791),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(14847) + laserdisc_frame_to_ms(1),
            timeout = { when=time_to_ms(6, 881), nextsequence="crash_landing" },
            actions = {
                { input="left", from=time_to_ms(2, 818), to=time_to_ms(5, 14), nextsequence="fell_to_death" },
                { input="left", from=time_to_ms(5, 14), to=time_to_ms(5, 341), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(5, 341), to=time_to_ms(5, 669), nextsequence="missed_jump" },
                { input="left", from=time_to_ms(5, 702), to=time_to_ms(6, 29), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(6, 29), to=time_to_ms(6, 357), nextsequence="fell_to_death" },
                { input="left", from=time_to_ms(6, 357), to=time_to_ms(6, 685), nextsequence="exit_room", points=3255 },
                { input="right", from=time_to_ms(2, 818), to=time_to_ms(7, 209), nextsequence="fell_to_death" },
                { input="up", from=time_to_ms(2, 818), to=time_to_ms(7, 209), nextsequence="fell_to_death" },
                { input="down", from=time_to_ms(2, 818), to=time_to_ms(7, 209), nextsequence="fell_to_death" },
            }
        },

        crash_landing = {  -- platform crashes into the floor at the bottom of the pit.
            start_time = time_laserdisc_frame(15226),
            kills_player = true,
            timeout = { when=time_to_ms(3, 47), nextsequence=nil }
        },

        missed_jump = {  -- player tried the jump but missed
            start_time = time_laserdisc_frame(15306),
            kills_player = true,
            timeout = { when=time_to_ms(2, 195), nextsequence=nil }
        },

        fell_to_death = {  -- player fell off the platform without jumping
            start_time = time_laserdisc_frame(15338),
            kills_player = true,
            timeout = { when=time_to_ms(0, 819), nextsequence=nil }
        },

        exit_room = {  -- player successfully makes the jump
            start_time = time_laserdisc_frame(15366),
            timeout = { when=time_to_ms(4, 653), nextsequence=nil },
        }
    },

    -- the one with nine chances to jump.
    falling_platform_long = {
        start_dead = {
            start_time = time_laserdisc_frame(14791),
            reversed_start_time = time_laserdisc_frame(21904),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(14847) + laserdisc_frame_to_ms(1),
            reversed_start_time = time_laserdisc_frame(21959),
            timeout = { when=time_to_ms(6, 816), nextsequence="second_jump_set", points = 49 },
            actions = {
                { input="left", from=time_to_ms(2, 818), to=time_to_ms(5, 14), nextsequence="fell_to_death" },
                { input="left", from=time_to_ms(5, 14), to=time_to_ms(5, 341), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(5, 341), to=time_to_ms(5, 669), nextsequence="fell_to_death" },
                { input="left", from=time_to_ms(5, 702), to=time_to_ms(6, 29), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(6, 29), to=time_to_ms(6, 357), nextsequence="missed_jump" },
                { input="left", from=time_to_ms(6, 357), to=time_to_ms(6, 685), nextsequence="exit_room", points=3255 },
                { input="right", from=time_to_ms(2, 818), to=time_to_ms(6, 750), nextsequence="fell_to_death" },
                { input="up", from=time_to_ms(2, 818), to=time_to_ms(6, 750), nextsequence="fell_to_death" },
                { input="down", from=time_to_ms(2, 818), to=time_to_ms(6, 750), nextsequence="fell_to_death" },
            }
        },

        second_jump_set = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(4, 293), nextsequence="third_jump_set", points = 1939 },
            actions = {
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(2, 458), nextsequence="fell_to_death" },
                { input="right", from=time_to_ms(2, 458), to=time_to_ms(2, 785), nextsequence="exit_room", points=3255 },
                { input="right", from=time_to_ms(2, 785), to=time_to_ms(3, 113), nextsequence="missed_jump" },
                { input="right", from=time_to_ms(3, 146), to=time_to_ms(3, 473), nextsequence="exit_room", points=3255 },
                { input="right", from=time_to_ms(3, 473), to=time_to_ms(3, 801), nextsequence="missed_jump" },
                { input="right", from=time_to_ms(3, 801), to=time_to_ms(4, 129), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(4, 293), nextsequence="fell_to_death" },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(4, 293), nextsequence="fell_to_death" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(4, 293), nextsequence="fell_to_death" },
            }
        },

        third_jump_set = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(4, 293), nextsequence="crash_landing" },
            actions = {
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(2, 458), nextsequence="missed_jump" },
                { input="left", from=time_to_ms(2, 458), to=time_to_ms(2, 785), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(2, 785), to=time_to_ms(3, 113), nextsequence="missed_jump" },
                { input="left", from=time_to_ms(3, 146), to=time_to_ms(3, 473), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(3, 473), to=time_to_ms(3, 801), nextsequence="missed_jump" },
                { input="left", from=time_to_ms(3, 801), to=time_to_ms(4, 129), nextsequence="exit_room", points=3255 },
                { input="left", from=time_to_ms(4, 162), to=time_to_ms(5, 571), nextsequence="fell_to_death" },
                { input="right", from=time_to_ms(0, 0), to=time_to_ms(5, 571), nextsequence="fell_to_death" },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(5, 571), nextsequence="fell_to_death" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(5, 571), nextsequence="fell_to_death" },
            }
        },

        crash_landing = {  -- platform crashes into the floor at the bottom of the pit.
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            kills_player = true,
            timeout = { when=time_to_ms(2, 32), nextsequence=nil }
        },

        missed_jump = {  -- player tried the jump but missed
            start_time = time_laserdisc_frame(15306),
            reversed_start_time = time_laserdisc_frame(22418),
            kills_player = true,
            timeout = { when=time_to_ms(2, 195), nextsequence=nil }
        },

        fell_to_death = {  -- player fell off the platform without jumping
            start_time = time_laserdisc_frame(15338),
            reversed_start_time = time_laserdisc_frame(22450),
            kills_player = true,
            timeout = { when=time_to_ms(0, 819), nextsequence=nil }
        },

        exit_room = {  -- player successfully makes the jump
            start_time = time_laserdisc_frame(15366),
            reversed_start_time = time_laserdisc_frame(22478),
            timeout = { when=time_to_ms(4, 653) + laserdisc_frame_to_ms(10), nextsequence=nil },
        }
    },

    falling_platform_long_reversed = {
        reverse_of = "falling_platform_long"
    },

    -- The tomb with the skulls, slime, skeletal hands, and ghouls
    crypt_creeps = {
        start_dead = {
            start_time = time_laserdisc_frame(11433),
            reversed_start_time = time_laserdisc_frame(18606),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {  -- skulls roll in
            start_time = time_laserdisc_frame(11489),
            reversed_start_time = time_laserdisc_frame(18662),
            timeout = { when=time_to_ms(3, 244), nextsequence="eaten_by_skulls" },
            actions = {
                { input="up", from=time_to_ms(2, 228), to=time_to_ms(3, 244), nextsequence="jumped_skulls", points=495 },
                { input="action", from=time_to_ms(2, 228), to=time_to_ms(3, 178), nextsequence="overpowered_by_skulls" },
                { input="down", from=time_to_ms(2, 228), to=time_to_ms(3, 178), nextsequence="eaten_by_skulls" },
                { input="right", from=time_to_ms(2, 228), to=time_to_ms(3, 178), nextsequence="eaten_by_skulls" },
                { input="left", from=time_to_ms(2, 228), to=time_to_ms(3, 178), nextsequence="eaten_by_skulls" },
            }
        },

        jumped_skulls = {   -- player jumped down the hall when skulls rolled in, first hand attacks
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 311), nextsequence="crushed_by_hand" },
            actions = {
                { input="action", from=time_to_ms(0, 688), to=time_to_ms(1, 278), nextsequence="attacked_first_hand", points=915 },
                { input="up", from=time_to_ms(0, 918), to=time_to_ms(1, 278), nextsequence="crushed_by_hand" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 311), nextsequence="eaten_by_skulls" },
                { input="left", from=time_to_ms(0, 668), to=time_to_ms(1, 278), nextsequence="crushed_by_hand" },
            }
        },

        attacked_first_hand = {   -- player drew sword and attacked the first skeletal hand, slime rolls in
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 195), nextsequence="eaten_by_slime" },
            actions = {
                { input="up", from=time_to_ms(1, 49), to=time_to_ms(2, 195), nextsequence="jumped_slime", points=495 },
                { input="down", from=time_to_ms(1, 49), to=time_to_ms(2, 163), nextsequence="eaten_by_skulls" },
                { input="right", from=time_to_ms(1, 49), to=time_to_ms(2, 163), nextsequence="eaten_by_slime" },
                { input="left", from=time_to_ms(1, 49), to=time_to_ms(2, 163), nextsequence="eaten_by_slime" },
            }
        },

        jumped_slime = {   -- player jumped down the hall when black slime rolled in, second hand attacks
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 212), nextsequence="crushed_by_hand" },
            actions = {
                { input="action", from=time_to_ms(0, 590), to=time_to_ms(1, 180), nextsequence="attacked_second_hand", points=915 },
                { input="up", from=time_to_ms(0, 590), to=time_to_ms(1, 147), nextsequence="crushed_by_hand" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 212), nextsequence="eaten_by_slime" },
                { input="right", from=time_to_ms(0, 590), to=time_to_ms(1, 147), nextsequence="crushed_by_hand" },
            }
        },

        attacked_second_hand = {   -- player drew sword and attacked the second skeletal hand, more slime rolls in
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 835), nextsequence="eaten_by_slime" },
            actions = {
                { input="left", from=time_to_ms(0, 426), to=time_to_ms(1, 835), nextsequence="enter_crypt", points=495 },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 835), nextsequence="eaten_by_slime" },
                { input="right", from=time_to_ms(0, 360), to=time_to_ms(1, 835), nextsequence="eaten_by_slime" },
            }
        },

        enter_crypt = {   -- player fled hallway, entered actual crypt
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 835), nextsequence="captured_by_ghouls" },
            actions = {
                { input="action", from=time_to_ms(0, 688), to=time_to_ms(1, 835), nextsequence="exit_room", points=495 },
                { input="up", from=time_to_ms(1, 81), to=time_to_ms(1, 835), nextsequence="captured_by_ghouls" },
                { input="down", from=time_to_ms(0, 688), to=time_to_ms(1, 835), nextsequence="captured_by_ghouls" },
                { input="right", from=time_to_ms(1, 81), to=time_to_ms(1, 835), nextsequence="captured_by_ghouls" },
                { input="left", from=time_to_ms(1, 81), to=time_to_ms(1, 835), nextsequence="captured_by_ghouls" },
            }
        },

        exit_room = {  -- player kills ghouls, heads through the exit
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(4, 227), nextsequence=nil },
        },

        overpowered_by_skulls = {  -- skulls got the player while drawing sword
            start_time = time_laserdisc_frame(11881),
            reversed_start_time = time_laserdisc_frame(19054),
            kills_player = true,
            timeout = { when=time_to_ms(1, 180), nextsequence=nil }
        },

        eaten_by_skulls = {  -- skulls got the player
            start_time = time_laserdisc_frame(11904),
            reversed_start_time = time_laserdisc_frame(19077),
            kills_player = true,
            timeout = { when=time_to_ms(0, 229), nextsequence=nil }
        },

        crushed_by_hand = {  -- giant skeletal hand got the player
            start_time = time_laserdisc_frame(11917),
            reversed_start_time = time_laserdisc_frame(19090),
            kills_player = true,
            timeout = { when=time_to_ms(0, 623), nextsequence=nil }
        },

        eaten_by_slime = {  -- black slime got the player
            start_time = time_laserdisc_frame(11940),
            reversed_start_time = time_laserdisc_frame(19114),
            kills_player = true,
            timeout = { when=time_to_ms(1, 212), nextsequence=nil }
        },

        captured_by_ghouls = {  -- ghouls got the player
            start_time = time_laserdisc_frame(11983),
            reversed_start_time = time_laserdisc_frame(19150),
            kills_player = true,
            timeout = { when=time_to_ms(2, 458), nextsequence=nil }
        }
    },

    -- The tomb with the skulls, slime, skeletal hands, and ghouls (reversed)
    crypt_creeps_reversed = {
        reverse_of = "crypt_creeps"
    },

    -- The flying horse machine that rides you past fires and other obstacles
    flying_horse = {
        start_dead = {
            start_time = time_laserdisc_frame(9965),
            reversed_start_time = time_laserdisc_frame(16488),
            timeout = { when=time_to_ms(2, 32), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {  -- Player mounts the horse, starts the wild ride, dodge first fire
            start_time = time_laserdisc_frame(10021),
            reversed_start_time = time_laserdisc_frame(16554),
            timeout = { when=time_to_ms(4, 522), nextsequence="hit_pillar" },
            actions = {  -- The reversed room has a different timing and control set here...!
                -- The ROM checks for UpRight here, but also an identical entry for Right which comes to the same result.
                { input="right", from=time_to_ms(3, 801), to=time_to_ms(4, 522), nextsequence="second_fire", points=495 },
                { input="up", from=time_to_ms(3, 801), to=time_to_ms(4, 522), nextsequence="hit_pillar" },
                { input="left", from=time_to_ms(3, 801), to=time_to_ms(4, 522), nextsequence="burned_to_death" },
            }
        },

        second_fire = {  -- dodge second fire
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 376), nextsequence="hit_pillar" },
            actions = {
                { input="left", from=time_to_ms(0, 721), to=time_to_ms(1, 343), nextsequence="third_fire", points=495 },
                { input="up", from=time_to_ms(0, 721), to=time_to_ms(1, 343), nextsequence="hit_pillar" },
                { input="right", from=time_to_ms(0, 721), to=time_to_ms(1, 343), nextsequence="burned_to_death" },
            }
        },

        third_fire = {  -- dodge third fire
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 835), nextsequence="hit_pillar" },
            actions = {
                { input="right", from=time_to_ms(1, 212), to=time_to_ms(1, 835), nextsequence="fourth_fire", points=495 },
                { input="up", from=time_to_ms(0, 852), to=time_to_ms(1, 802), nextsequence="hit_pillar" },
                { input="left", from=time_to_ms(1, 212), to=time_to_ms(1, 835), nextsequence="burned_to_death" },
            }
        },

        fourth_fire = {  -- dodge fourth fire
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 966), nextsequence="hit_pillar" },
            actions = {
                { input="left", from=time_to_ms(1, 311), to=time_to_ms(1, 966), nextsequence="brick_wall", points=495 },
                { input="up", from=time_to_ms(1, 49), to=time_to_ms(1, 966), nextsequence="hit_pillar" },
                { input="right", from=time_to_ms(1, 311), to=time_to_ms(1, 966), nextsequence="burned_to_death" },
            }
        },

        brick_wall = {  -- dodge a brick wall
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 868), nextsequence="hit_brick_wall" },
            actions = {
                { input="left", from=time_to_ms(1, 311), to=time_to_ms(1, 868), nextsequence="fifth_fire", points=1326 },
                { input="up", from=time_to_ms(0, 950), to=time_to_ms(1, 835), nextsequence="hit_brick_wall" },
                { input="right", from=time_to_ms(0, 950), to=time_to_ms(1, 835), nextsequence="hit_brick_wall" },
            }
        },

        fifth_fire = {  -- dodge fifth fire
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 409), nextsequence="hit_pillar" },
            actions = {
                { input="left", from=time_to_ms(0, 721), to=time_to_ms(1, 376), nextsequence="exit_room", points=495 },
                { input="up", from=time_to_ms(0, 393), to=time_to_ms(1, 409), nextsequence="hit_pillar" },
                { input="right", from=time_to_ms(0, 721), to=time_to_ms(1, 376), nextsequence="burned_to_death" },
            }
        },

        exit_room = {  -- player crash lands safely, exits room.
            start_time = time_laserdisc_noseek(),
            reversed_start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(5, 50), nextsequence=nil },
        },

        burned_to_death = {  -- player ran into the wall of flames
            start_time = time_laserdisc_frame(10565),
            reversed_start_time = time_laserdisc_frame(16976),
            kills_player = true,
            timeout = { when=time_to_ms(1, 180), nextsequence=nil }
        },

        hit_pillar = {  -- player ran into the pillar
            start_time = time_laserdisc_frame(10453),
            reversed_start_time = time_laserdisc_frame(16976),
            kills_player = true,
            timeout = { when=time_to_ms(1, 638), nextsequence=nil }
        },

        hit_brick_wall = {  -- player ran into the brick wall
            start_time = time_laserdisc_frame(10501),
            reversed_start_time = time_laserdisc_frame(17024),
            kills_player = true,
            timeout = { when=time_to_ms(2, 327), nextsequence=nil }
        }
    },

    -- The flying horse machine that rides you past fires and other obstacles (reversed)
    -- THIS DOES NOT USE THE SAME INPUTS AS ITS MIRROR VERSION!
--    flying_horse_reversed = {
--    },


    -- The giddy goons!
    giddy_goons = {
        start_dead = {
            start_time = time_laserdisc_frame(5627),
            timeout = { when=time_to_ms(1, 966), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {  -- Player runs into the goons!!
            start_time = time_laserdisc_frame(5683),
            timeout = { when=time_to_ms(3, 146), nextsequence="knife_in_back" },
            actions = {
                { input="action", from=time_to_ms(2, 392), to=time_to_ms(3, 113), nextsequence="kills_first_goon", points=379 },
                { input="up", from=time_to_ms(1, 507), to=time_to_ms(2, 392), nextsequence="fall_to_death" },
                { input="right", from=time_to_ms(2, 392), to=time_to_ms(3, 113), nextsequence="knife_in_back" },
                { input="left", from=time_to_ms(2, 392), to=time_to_ms(3, 113), nextsequence="swarm_of_goons" },
            }
        },

        kills_first_goon = {  -- player kills first goon, moves towards stairs.
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 835), nextsequence="knife_in_back" },
            actions = {
                -- the ROM has an "UpRight" action that matches the successful "Right" (but "Up" by itself is a fail), so we just check "Right" first so the player will pass if they're hitting both.
                { input="right", from=time_to_ms(1, 114), to=time_to_ms(1, 835), nextsequence="climbs_stairs", points=1326 },
                { input="up", from=time_to_ms(0, 885), to=time_to_ms(1, 802), nextsequence="fall_to_death" },
                { input="left", from=time_to_ms(1, 114), to=time_to_ms(1, 835), nextsequence="shoves_off_edge" },
                { input="action", from=time_to_ms(1, 114), to=time_to_ms(1, 835), nextsequence="shoves_off_edge" },
            }
        },

        climbs_stairs = {  -- Player climbs the stairs, meets more resistance
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 163), nextsequence="swarm_of_goons" },
            actions = {
                { input="action", from=time_to_ms(1, 475), to=time_to_ms(2, 130), nextsequence="kill_upper_goons", points=3255 },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(2, 130), nextsequence="kill_upper_goons", points=3255 },
                { input="up", from=time_to_ms(1, 475), to=time_to_ms(2, 130), nextsequence="fight_off_one_before_swarm" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(2, 163), nextsequence="fight_off_one_before_swarm" },
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(2, 163), nextsequence="fall_to_death" },
            }
        },

        kill_upper_goons = {  -- Player kills the goons at the top of the stairs.
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 606), nextsequence="exit_room" },
            actions = {
                -- The ROM has an "UpLeft" action here, but it matches its separate "Up" and "Left" entries.
                { input="up", from=time_to_ms(0, 852), to=time_to_ms(1, 540), nextsequence="exit_room" },
                { input="left", from=time_to_ms(0, 852), to=time_to_ms(1, 540), nextsequence="exit_room" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 606), nextsequence="fight_off_one_before_swarm" },
                { input="action", from=time_to_ms(0, 786), to=time_to_ms(1, 573), nextsequence="fight_off_one_before_swarm" },
            }
        },

        exit_room = {  -- player heads for the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 835), nextsequence=nil },
        },

        knife_in_back = {  -- player gets a knife in the back
            start_time = time_laserdisc_frame(6039),
            kills_player = true,
            timeout = { when=time_to_ms(1, 835), nextsequence=nil }
        },

        shoves_off_edge = {  -- goons push player off edge
            start_time = time_laserdisc_frame(6091),
            kills_player = true,
            timeout = { when=time_to_ms(2, 720), nextsequence=nil }
        },

        fall_to_death = {  -- player falls down into pit
            start_time = time_laserdisc_frame(6163),
            kills_player = true,
            timeout = { when=time_to_ms(1, 180), nextsequence=nil }
        },

        fight_off_one_before_swarm = {  -- Player kills one, then swarm takes him down.
            start_time = time_laserdisc_frame(5947),
            kills_player = true,
            timeout = { when=time_to_ms(3, 375), nextsequence=nil }
        },

        swarm_of_goons = {  -- giddy goons swarm dirk.
            start_time = time_laserdisc_frame(6015),
            kills_player = true,
            timeout = { when=time_to_ms(0, 655), nextsequence=nil }
        }
    },

    -- Green tentacles flood in to the room.
    tentacle_room = {
        start_dead = {
            start_time = time_laserdisc_frame(2297),
            timeout = { when=time_to_ms(1, 966), nextsequence="enter_room", points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(2353),
            timeout = { when=time_to_ms(3, 965), nextsequence="left_tentacle_grabs" },
            actions = {
                { input="action", from=time_to_ms(2, 687), to=time_to_ms(3, 965), nextsequence="kills_first_tentacle", points=49 }
            }
        },

        kills_first_tentacle = {  -- player slashes first tentacle
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 359), nextsequence="squeeze_to_death" },
            actions = {
                { input="up", from=time_to_ms(1, 409), to=time_to_ms(2, 327), nextsequence="jump_to_weapon_rack", points=379 }
            }
        },

        jump_to_weapon_rack = {  -- player jumps to weapon rack on far wall
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 901), nextsequence="squeeze_to_death" },
            actions = {
                { input="right", from=time_to_ms(1, 180), to=time_to_ms(1, 933), nextsequence="jump_to_door", points=495 },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(1, 901), nextsequence="squeeze_to_death" },
                { input="action", from=time_to_ms(0, 0), to=time_to_ms(1, 901), nextsequence="squeeze_to_death" },
                { input="left", from=time_to_ms(1, 180), to=time_to_ms(1, 933), nextsequence="squeeze_to_death" },
            }
        },

        jump_to_door = {  -- player jumps to door far wall
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 442), nextsequence="squeeze_to_death_by_door" },
            actions = {
                -- ROM has "DownRight" with identical "Down" and "Right" entries, so this is fine.
                { input="down", from=time_to_ms(0, 492), to=time_to_ms(1, 409), nextsequence="jump_to_stairs", points=915 },
                { input="right", from=time_to_ms(0, 492), to=time_to_ms(1, 409), nextsequence="jump_to_stairs", points=915 },
                { input="up", from=time_to_ms(0, 492), to=time_to_ms(1, 409), nextsequence="squeeze_to_death_by_door" },
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(1, 442), nextsequence="squeeze_to_death" },
                { input="action", from=time_to_ms(0, 0), to=time_to_ms(1, 475), nextsequence="squeeze_to_death" },
            }
        },

        jump_to_stairs = {  -- player jumps to base of staircase, starts to climb
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 720), nextsequence="two_front_war" },
            actions = {
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(1, 966), nextsequence="squeeze_to_death" },
                { input="left", from=time_to_ms(1, 966), to=time_to_ms(2, 720), nextsequence="jump_to_table", points=1326 },
                { input="up", from=time_to_ms(0, 0), to=time_to_ms(2, 720), nextsequence="two_front_war" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(2, 720), nextsequence="squeeze_to_death" },
                { input="action", from=time_to_ms(0, 0), to=time_to_ms(2, 720), nextsequence="two_front_war" },
            }
        },

        jump_to_table = {  -- player jumps back down the stairs to the table
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(2, 228), nextsequence="squeeze_to_death" },
            actions = {
                -- ROM has "UpRight" with identical "Up" and "Right" entries, so this is fine.
                { input="up", from=time_to_ms(0, 360), to=time_to_ms(2, 195), nextsequence="exit_room", points=1939 },
                { input="right", from=time_to_ms(0, 360), to=time_to_ms(2, 195), nextsequence="exit_room", points=1939 },
                { input="left", from=time_to_ms(0, 0), to=time_to_ms(2, 228), nextsequence="squeeze_to_death" },
                { input="action", from=time_to_ms(0, 0), to=time_to_ms(2, 228), nextsequence="squeeze_to_death" },
                { input="down", from=time_to_ms(0, 0), to=time_to_ms(2, 228), nextsequence="squeeze_to_death" },
            }
        },

        exit_room = {  -- player heads for the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(1, 28), nextsequence=nil },
        },

        left_tentacle_grabs = {  -- player gets grabbed by first tentacle in the room.
            start_time = time_laserdisc_frame(2729),
            kills_player = true,
            timeout = { when=time_to_ms(2, 621), nextsequence=nil }
        },

        squeeze_to_death = {  -- tentacles wrap around player in close-up and squeeze him to death
            start_time = time_laserdisc_frame(2801),
            kills_player = true,
            timeout = { when=time_to_ms(1, 638), nextsequence=nil }
        },

        two_front_war = {  -- player slashes tentacle on the right, but left tentacle sneaks up on him
            start_time = time_laserdisc_frame(2849),
            kills_player = true,
            timeout = { when=time_to_ms(2, 621), nextsequence=nil }
        },

        squeeze_to_death_by_door = {  -- tentacles wrap around player in close-up and squeeze him to death, door in background.
            start_time = time_laserdisc_frame(2933),
            kills_player = true,
            timeout = { when=time_to_ms(0, 623), nextsequence=nil }
        },
    },
}

-- end of lair.lua ...

