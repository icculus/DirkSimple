--
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
local current_scene = nil
local input_accepted_until = 0
local run_after_clip = nil


-- FUNCTIONS

local function time_to_ms(minutes, seconds, ms)
    return (((minutes * 60) + seconds) * 1000) + ms
end

local function play_clip_then(startms, durationms, thenfn)
    DirkSimple.tick = function(clipms, inputs)
        if clipms >= durationms then
            DirkSimple.tick = standard_tick;
            thenfn()
        end
    end
    DirkSimple.start_clip(startms, durationms)
end

local function start_current_scene_gameplay()
    input_accepted_until = 0
    DirkSimple.start_clip(current_scene.start_time, current_scene.duration)
end


local function start_scene(scenename, is_resurrection)
print("Running start_scene ('" .. scenename .. "', " .. tostring(is_resurrection) .. ")")
    current_scene = scenes[scenename]
    if is_resurrection and (current_scene.resurrect_start_time ~= nil) and (current_scene.resurrect_duration ~= nil) then
        play_clip_then(current_scene.resurrect_start_time, current_scene.resurrect_duration, start_current_scene_gameplay)
    else
        start_current_scene_gameplay()
    end
end

local function start_attract_mode()
    start_scene('attract_mode', false)
end

local function game_over()
    if (current_scene ~= nil) and (current_scene.gameover_start_time ~= nil) and (current_scene.gameover_duration ~= nil) then
        play_clip_then(current_scene.gameover_start_time, current_scene.gameover_duration, start_attract_mode)
    else
        start_attract_mode()
    end
end

local function start_game()
    lives_left = starting_lives
    start_scene('bower', false)   -- !!! FIXME: this is just temp code until we have more scenes and a way to manage them.
end

local function kill_player()
print("Running kill_player (lives_left=" .. lives_left .. ")")
    if lives_left > 0 then
        lives_left = lives_left - 1
    end
    if lives_left == 0 then
        game_over()
    else
        start_scene('bower', true)  -- !!! FIXME: just replays the bower for now. Should select the next level.
    end
end

local function failscene(clip_start_time, clip_duration)
    return function()
print("Running failscene (" .. clip_start_time .. ", " .. clip_duration .. ")");
        play_clip_then(clip_start_time, clip_duration, kill_player)
    end
end

local function acceptinput_until(ms)
    return function()
        -- !!! FIXME: positive beep to acknowledge input
        input_accepted_until = ms
    end
end

local function check_actions(clipms, inputs)
    if input_accepted_until == -1 then
        return false  -- ignore all input until end of scene.
    elseif input_accepted_until >= clipms then
        return false  -- ignore input until later in the scene.
    end

    local noneaccepted = nil
    for i,v in ipairs(current_scene.actions) do
        if (clipms >= v.from) and (clipms <= v.to) then  -- ignore if not in the time window for this input.
            local input = v.input
            if input == 'noneaccepted' then   -- save this off, in case nothing else is accepted this frame.
                noneaccepted = v  -- shame on you if there are two of these valid at the same time!
            elseif inputs.pressed[input] then  -- we got one!
                print("action: " .. input)
                v.actionfn()
                return true
            end
        end
    end

    if noneaccepted ~= nil then
        print("action: noneaccepted")
        noneaccepted.actionfn()
        return true
    end

    return false
end

standard_tick = function(clipms, inputs)
    if current_scene == nil then
        start_attract_mode()
    elseif check_actions(clipms, inputs) then
        return  -- we did _something_ this tick
    elseif clipms >= current_scene.duration then  -- player won the scene.
        start_scene('bower', false)  -- !!! FIXME: just replays the bower for now.
    end
end

-- Start with standard_tick, but other things might override it later.
DirkSimple.tick = standard_tick


-- The scene table!
-- http://www.dragons-lair-project.com/games/related/sequence.asp
scenes = {
    attract_mode = {
        start_time = time_to_ms(0, 7, 0),
        duration = time_to_ms(0, 43, 0),
        actions = {
            -- Player hit start to start the game
            { input="start", from=time_to_ms(0, 0, 0), to=time_to_ms(60, 0, 0), actionfn=start_game },
            -- Attract mode ran to completion, restart it.
            { input="noneaccepted", from=time_to_ms(0, 42, 900), to=time_to_ms(60, 0, 0), actionfn=start_attract_mode },
        }
    },

    -- Bedroom where brick wall appears in front of you to be jumped through.
    bower = {
        resurrect_start_time = time_to_ms(6, 13, 0),
        resurrect_duration = time_to_ms(0, 2, 0),
        gameover_start_time = time_to_ms(6, 25, 0),
        gameover_duration = time_to_ms(0, 4, 0),
        start_time = time_to_ms(6, 15, 200),
        duration = time_to_ms(0, 6, 0),
        actions = {
            -- Successful jump through the wall.
            { input="up", from=time_to_ms(0, 2, 0), to=time_to_ms(0, 3, 500), actionfn=acceptinput_until(-1) },
            -- Jumped through the wall too late.
            { input="up", from=time_to_ms(0, 3, 500), to=time_to_ms(0, 4, 0), actionfn=failscene(time_to_ms(6, 21, 0), time_to_ms(0, 2, 0)) },
            -- No move in time, room fills with poison gas.
            { input="noneaccepted", from=time_to_ms(0, 3, 0), to=time_to_ms(0, 6, 0), actionfn=failscene(time_to_ms(6, 23, 0), time_to_ms(0, 1, 800)) },
        }
    }
}

-- end of lair.lua ...

