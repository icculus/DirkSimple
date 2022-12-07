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


-- GAME STATE

local lives_left = 0
local current_score = 0
local current_scene = nil
local current_scene_name = nil
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

local function time_to_ms(minutes, seconds, ms)
    return (((minutes * 60) + seconds) * 1000) + ms
end

local function start_sequence(sequencename)
    DirkSimple.log("Starting sequence '" .. sequencename .. "'")
    current_sequence = current_scene[sequencename]
    accepted_input = nil
    if current_sequence.start_time < 0 then  -- if negative, no seek desired (just keep playing from current location)
        current_sequence_tick_offset = current_sequence_tick_offset + current_sequence_ticks
    else
        DirkSimple.start_clip(current_sequence.start_time)  -- will suspend ticking until the seek completes and reset sequence tick count
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
    start_sequence(sequencename)
end

local function start_attract_mode(after_game_over)
    start_scene('attract_mode', after_game_over)
end

local function game_over(won)
    DirkSimple.log("Game over!")
    -- !!! FIXME: show correct game over scene
    --if (current_scene ~= nil) and (current_scene.gameover_start_time ~= nil) and (current_scene.gameover_duration ~= nil) then
    --    play_clip_then(current_scene.gameover_start_time, current_scene.gameover_duration, start_attract_mode)
    --else
        start_attract_mode(true)
    --end
end

local function choose_next_scene(is_resurrection)
    -- this is obviously going to get more complex later.

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

    if current_sequence.actions ~= nil then
        for i,v in ipairs(current_sequence.actions) do
            -- ignore if not in the time window for this input.
            if (current_sequence_ticks >= v.from) and (current_sequence_ticks <= v.to) then
                local input = v.input
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

    if outcome.award_points ~= nil then
        current_score = current_score + outcome.award_points
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
        check_timeout(0)
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
            start_time = time_to_ms(0, 7, 0),
            timeout = { when=time_to_ms(0, 43, 0), next_sequence="start_alive" },
            actions = {
                -- Player hit start to start the game
                { input="start", from=time_to_ms(0, 0, 0), to=time_to_ms(60, 0, 0), interrupt=start_game, nextsequence=nil },
            }
        },
        start_dead = {
            start_time = time_laserdisc_noseek(),  -- !!! FIXME: Queue up the game over frame and pause there for a few seconds.
            timeout = { when=0, nextsequence="start_alive" },
        },
    },

    -- Intro level, no gameplay in the arcade version.
    introduction = {
        start_dead = {
            start_time = time_laserdisc_frame(1367),
            timeout = { when=time_to_ms(0, 2, 32), nextsequence="castle_exterior" }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="castle_exterior" }
        },

        castle_exterior = {  -- exterior shot of the castle
            start_time = time_laserdisc_frame(1424),
            timeout = { when=time_to_ms(0, 5, 767), nextsequence="exit_room" },
        },

        -- this skips the drawbridge itself, like the arcade does.
        exit_room = {  -- player runs through the gates.
            start_time = time_laserdisc_frame(1823) - laserdisc_frame_to_ms(2),
            timeout = { when=time_to_ms(0, 2, 359) + laserdisc_frame_to_ms(10), nextsequence=nil },
        },
    },

    -- Swinging ropes, burning over a fiery pit.
    flaming_ropes = {
        start_dead = {
            start_time = time_laserdisc_frame(3505),
            timeout = { when=time_to_ms(0, 2, 228), nextsequence="enter_room" }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", award_points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(3561),
            timeout = { when=time_to_ms(0, 2, 228), nextsequence="platform_sliding" },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 245), nextsequence="fall_to_death", award_points=-49 },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 1, 245), to=time_to_ms(0, 2, 130), nextsequence="rope1", award_points=251 },
                -- Player grabs rope too late
                { input="right", from=time_to_ms(0, 2, 130), to=time_to_ms(0, 4, 260), nextsequence="fall_to_death", award_points=-49 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 2, 490), nextsequence="fall_to_death", award_points=-49 },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 2, 490), nextsequence="fall_to_death", award_points=-49 },
            }
        },

        platform_sliding = {  -- Player hesitated, platform starts pulling back
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 2, 621), nextsequence="fall_to_death", award_points=-49 },  -- player hesitated, platform is gone, player falls
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-49 },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 1, 835), to=time_to_ms(0, 2, 884), nextsequence="rope1", award_points=251 },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 1, 835), to=time_to_ms(0, 2, 884), nextsequence="fall_to_death", award_points=-49 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 2, 884), nextsequence="fall_to_death", award_points=-49 },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 2, 884), nextsequence="fall_to_death", award_points=-49 },
            }
        },

        rope1 = {  -- player grabbed first rope
            start_time = time_laserdisc_frame(3693),
            timeout = { when=time_to_ms(0, 2, 228), nextsequence="burns_hands", award_points=-300 },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 81), nextsequence="fall_to_death", award_points=-300 },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 1, 81), to=time_to_ms(0, 1, 835), nextsequence="rope2", award_points=379 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-300 },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-300 },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-300 },
            }
        },

        rope2 = {  -- player grabbed second rope
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 2, 228), nextsequence="burns_hands", award_points=-679 },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 81), nextsequence="fall_to_death", award_points=-679 },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 1, 81), to=time_to_ms(0, 1, 835), nextsequence="rope3", award_points=495 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-679 },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-679 },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 835), nextsequence="fall_to_death", award_points=-679 },
            }
        },

        rope3 = {  -- player grabbed third rope
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 1, 507), nextsequence="misses_landing", award_points=-1174 },
            actions = {
                -- Player grabs rope too soon
                { input="right", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 0, 852), nextsequence="fall_to_death", award_points=-1174 },
                -- Player grabs rope correctly
                { input="right", from=time_to_ms(0, 0, 852), to=time_to_ms(0, 1, 704), nextsequence="exit_room", award_points=915 },
                -- Player tries to fly
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 769), nextsequence="fall_to_death", award_points=-1174 },
                -- Player tries to dive
                { input="down", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 769), nextsequence="fall_to_death", award_points=-1174 },
                -- Player tries to flee
                { input="left", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 769), nextsequence="fall_to_death", award_points=-1174 },
            }
        },

        exit_room = {  -- player reaches exit platform
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 1, 49), nextsequence=nil },
        },

        misses_landing = {  -- player landed on exit platform, but fell backwards
            start_time = time_laserdisc_frame(3879),
            kills_player = true,
            timeout = { when=time_to_ms(0, 1, 540), nextsequence=nil },
        },

        burns_hands = {  -- rope burns up to hands, making player fall
            start_time = time_laserdisc_frame(3925),
            timeout = { when=time_to_ms(0, 1, 475), nextsequence="fall_to_death" }
        },

        fall_to_death = {  -- player falls into the flames
            start_time = time_laserdisc_frame(3963),
            kills_player = true,
            timeout = { when=time_to_ms(0, 1, 180), nextsequence=nil }
        }
    },

    -- Bedroom where brick wall appears in front of you to be jumped through.
    bower = {
        start_dead = {
            start_time = time_laserdisc_frame(9093),
            timeout = { when=time_to_ms(0, 2, 32), nextsequence="enter_room", award_points = 49 }
        },

        start_alive = {
            start_time = time_laserdisc_noseek(),
            timeout = { when=0, nextsequence="enter_room", award_points = 49 }
        },

        enter_room = {
            start_time = time_laserdisc_frame(9181) - laserdisc_frame_to_ms(15),
            timeout = { when=time_to_ms(0, 1, 147) + laserdisc_frame_to_ms(15), nextsequence="trapped_in_wall" },
            actions = {
                -- Player jumps through the hole in the wall
                { input="up", from=time_to_ms(0, 0, 0), to=time_to_ms(0, 1, 409) + laserdisc_frame_to_ms(15), nextsequence="exit_room", award_points=379 },
            }
        },

        trapped_in_wall = {  -- player fails to climb through.
            start_time = time_laserdisc_frame(9301) - laserdisc_frame_to_ms(15),
            kills_player = true,
            timeout = { when=time_to_ms(0, 0, 492) + laserdisc_frame_to_ms(30), nextsequence=nil }
        },

        exit_room = {  -- player reaches the door
            start_time = time_laserdisc_noseek(),
            timeout = { when=time_to_ms(0, 2, 425) + laserdisc_frame_to_ms(15), nextsequence=nil },
        },
    },


}

-- end of lair.lua ...

