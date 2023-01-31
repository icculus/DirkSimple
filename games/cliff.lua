-- DirkSimple; a dirt-simple player for FMV games.
--
-- Please see the file LICENSE.txt in the source's root directory.
--
--  This file written by Ryan C. Gordon.
--

DirkSimple.gametitle = "Cliff Hanger"

-- SOME GAME CONFIG STUFF
local starting_lives = 5


-- SOME INITIAL SETUP STUFF
local scenes = nil  -- gets set up later in the file.
local test_scene = nil  -- set to name of scene to test. nil otherwise!
--test_scene = 1

-- GAME STATE
local scene_manager = {}


-- FUNCTIONS

-- Cliff Hanger counts frames at 30fps, not 23.976fps like Dragon's Lair.
local function laserdisc_frame_to_ms(frame)
    return ((frame / 30.0) * 1000.0)
end

local function seek_laserdisc_to(frame)
    -- will suspend ticking until the seek completes and reset sequence tick count
    scene_manager.last_seek = laserdisc_frame_to_ms(frame - 6)
    scene_manager.unserialize_offset = 0
    DirkSimple.start_clip(scene_manager.last_seek)
end

local function setup_scene_manager()
    scene_manager.initialized = true
    scene_manager.accepted_input = nil
    scene_manager.in_attract_mode = false
    scene_manager.in_death_scene = false
    scene_manager.infinite_lives = false
    scene_manager.lives_left = starting_lives
    scene_manager.current_score = 0
    scene_manager.last_seek = 0
    scene_manager.current_scene = nil
    scene_manager.current_scene_num = 0
    scene_manager.current_sequence = nil
    scene_manager.current_sequence_num = 0
    scene_manager.current_scene_ticks = 0
    scene_manager.laserdisc_frame = 0
    scene_manager.unserialize_offset = 0
end

local function start_attract_mode(after_game_over)
    -- !!! FIXME: need some graphics rendered here.
    scene_manager.in_attract_mode = true
    scene_manager.current_scene_num = 0
    scene_manager.current_scene = nil
    scene_manager.current_sequence_num = 0
    scene_manager.current_sequence = nil
    scene_manager.accepted_input = nil
    seek_laserdisc_to(6)
end

local function start_scene(scenenum, sequencenum)
    if test_scene ~= nil then
        scene_manager.infinite_lives = true
        scenenum = test_scene
        sequencenum = 0
    end

    local start_of_scene = (sequencenum == 0)
    if start_of_scene then
        sequencenum = 1
    end

    local seqname = nil
    if (scenes[scenenum] ~= nil) and (scenes[scenenum].moves ~= nil) and (scenes[scenenum].moves[sequencenum] ~= nil) then
        seqname = scenes[scenenum].moves[sequencenum].name
    end
    if seqname ~= nil then
        seqname = " (" .. seqname .. ")"
    else
        seqname = ''
    end

    DirkSimple.log("Starting scene " .. scenenum .. " (" .. scenes[scenenum].scene_name .. "), sequence " .. sequencenum .. seqname)
    scene_manager.current_scene_num = scenenum
    scene_manager.current_scene = scenes[scenenum]
    scene_manager.current_sequence_num = sequencenum
    scene_manager.current_sequence = scene_manager.current_scene.moves[sequencenum]
    scene_manager.accepted_input = nil

    local startframe = 0
    if start_of_scene then
        start_frame = scene_manager.current_scene.start_frame
    else
        start_frame = scene_manager.current_sequence.start_frame
    end

    seek_laserdisc_to(start_frame)
end

local function start_game()
    DirkSimple.log("Start game!")
    setup_scene_manager()
    start_scene(1, 0)
end

local function game_over(won)
    DirkSimple.log("Game over!")
    -- !!! FIXME: do more here
    scene_manager.accepted_input = nil
    start_attract_mode(true)
end

local function kill_player()  -- !!! FIXME: this needs to display a message
    if scene_manager.infinite_lives then
        scene_manager.lives_left = starting_lives
    elseif scene_manager.lives_left > 0 then
        scene_manager.lives_left = scene_manager.lives_left - 1
    end

    DirkSimple.log("Killing player (lives now left=" .. scene_manager.lives_left .. ")")

    scene_manager.in_death_scene = true
    if scene_manager.current_sequence.death_start_frame ~= 0 then
        seek_laserdisc_to(scene_manager.current_sequence.death_start_frame)
    end
end

local function tick_attract_mode(inputs)
    -- !!! FIXME: need some graphics rendered here.
    if scene_manager.in_attract_mode then
        if inputs.pressed["start"] then
            start_game()
        elseif scene_manager.laserdisc_frame >= 1546 then
            start_attract_mode(false)   -- if we're at the end of the attract mode clip, restart it.
        end
    end
end

local function move_was_made(inputs, actions)
    if actions ~= nil then
        for i,v in ipairs(actions) do
            local input = v
            if input == "hands" then
                input = "action"
            elseif input == "feet" then
                input = "action2"
            end

            if inputs.pressed[input] then  -- we got one!
                DirkSimple.log("accepted action '" .. v .. "' at " .. tostring(scene_manager.current_scene_ticks / 1000.0))
                return v
            end
        end
    end
    return nil
end

local function tick_death_scene()
    -- has death scene finished?
    if scene_manager.laserdisc_frame >= scene_manager.current_sequence.death_end_frame then
        scene_manager.in_death_scene = false
        if scene_manager.lives_left == 0 then
            game_over(false)
        else
            -- In Cliff Hanger, you have to complete each scene in order, before you can do a different one.
            start_scene(scene_manager.current_scene_num, scene_manager.current_sequence.restart_move)  -- move back to where the sequence prescribes.
        end
    end
end

local function tick_game(inputs)
    -- if sequence is nil, we've run through all the moves for the scene and are just waiting on the scene to finish playing.
    local sequence = scene_manager.current_sequence
    local laserdisc_frame = scene_manager.laserdisc_frame

    --DirkSimple.log("TICK GAME: ticks=" .. scene_manager.current_scene_ticks .. ", laserdisc_frame=" .. laserdisc_frame)

    -- see if it's time to shift to the next sequence.
    if (sequence ~= nil) and (laserdisc_frame >= sequence.end_frame) then
        if (scene_manager.accepted_input == nil) and (sequence.correct_moves ~= nil) and (#sequence.correct_moves ~= 0) then
            -- uhoh, player did nothing, they blew it.
            kill_player()
            return
        end

        -- ok, you survived this sequence, moving on to the next!
        scene_manager.accepted_input = nil
        scene_manager.current_sequence_num = scene_manager.current_sequence_num + 1
        scene_manager.current_sequence = scene_manager.current_scene.moves[scene_manager.current_sequence_num]
        sequence = scene_manager.current_sequence

        local seqname = sequence.name
        if seqname ~= nil then
            seqname = " (" .. seqname .. ")"
        else
            seqname = ''
        end
        DirkSimple.log("Moving on to sequence " .. scene_manager.current_sequence_num .. seqname)
    end

    -- are we in the window for moves in this sequence?
    if (sequence ~= nil) and (scene_manager.accepted_input == nil) and (laserdisc_frame >= sequence.start_frame) then
        if move_was_made(inputs, sequence.incorrect_moves) then
            kill_player()
            return
        else
            scene_manager.accepted_input = move_was_made(inputs, sequence.correct_moves)
        end
    end

    -- see if the entire scene has ended.
    if laserdisc_frame >= scene_manager.current_scene.end_frame then
        if scene_manager.current_scene_num >= #scenes then  -- out of scenes? You won the game!
            game_over(true)
        else
            start_scene(scene_manager.current_scene_num + 1, 0)
        end
    end
end

DirkSimple.tick = function(ticks, sequenceticks, inputs)
    scene_manager.current_scene_ticks = sequenceticks + scene_manager.unserialize_offset
    scene_manager.laserdisc_frame = ((scene_manager.last_seek + scene_manager.current_scene_ticks) / (1000.0 / 30.0)) + 6

    if scene_manager.in_attract_mode then
        tick_attract_mode(inputs)
    elseif scene_manager.in_death_scene then
        tick_death_scene()
    elseif scene_manager.current_sequence == nil then
        start_attract_mode(false)
    else
        tick_game(inputs)
    end
end

DirkSimple.serialize = function()
    if not scene_manager.initialized then
        setup_scene_manager()   -- just so we can serialize a default state.
    end

    local state = {}
    state[#state + 1] = 1   -- current serialization version
    state[#state + 1] = scene_manager.infinite_lives
    state[#state + 1] = scene_manager.lives_left
    state[#state + 1] = scene_manager.current_score
    state[#state + 1] = scene_manager.in_attract_mode
    state[#state + 1] = scene_manager.in_death_scene
    state[#state + 1] = scene_manager.last_seek
    state[#state + 1] = scene_manager.current_scene_num
    state[#state + 1] = scene_manager.current_sequence_num
    state[#state + 1] = scene_manager.current_scene_ticks
    state[#state + 1] = scene_manager.accepted_input

    return state
end


DirkSimple.unserialize = function(state)
    -- !!! FIXME: this function assumes that `state` is completely valid. It doesn't check array length or data types.
    setup_scene_manager()

    local idx = 1
    local version = state[idx] ; idx = idx + 1
    scene_manager.infinite_lives = state[idx] ; idx = idx + 1
    scene_manager.lives_left = state[idx] ; idx = idx + 1
    scene_manager.current_score = state[idx] ; idx = idx + 1
    scene_manager.in_attract_mode = state[idx] ; idx = idx + 1
    scene_manager.in_death_scene = state[idx] ; idx = idx + 1
    scene_manager.last_seek = state[idx] ; idx = idx + 1
    scene_manager.current_scene_num = state[idx] ; idx = idx + 1
    scene_manager.current_sequence_num = state[idx] ; idx = idx + 1
    scene_manager.current_scene_ticks = state[idx] ; idx = idx + 1
    scene_manager.accepted_input = state[idx] ; idx = idx + 1

    scene_manager.unserialize_offset = scene_manager.current_scene_ticks
    scene_manager.laserdisc_frame = ((scene_manager.last_seek + scene_manager.current_scene_ticks) / (1000.0 / 30.0)) + 6

    if scene_manager.current_scene_num ~= 0 then
        scene_manager.current_scene = scenes[scene_manager.current_scene_num]
        if scene_manager.current_sequence_num ~= 0 then
            scene_manager.current_sequence = scene_manager.current_scene[scene_manager.current_sequence_num]
        end
    end

    DirkSimple.start_clip(scene_manager.last_seek + scene_manager.unserialize_offset)

    return true
end


setup_scene_manager()  -- Call this during initial load to make sure the table is ready to go.



-- The scene table!
-- https://www.jeffsromhack.com/code/cliffhanger.htm
scenes = {

    -- scene 1
    {
        scene_name = "Bank Heist",
        start_frame = 1547,
        end_frame = 3160,
        dunno1_frame = 0,
        dunno2_frame = 0,
        moves = {
            {
                name = "Running from the casino",
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 1800,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                name = "Jump first hurdle",
                correct_moves = { "feet" },
                incorrect_moves = { "hands" },
                start_frame = 1928,
                end_frame = 1987,
                death_start_frame = 3930,
                death_end_frame = 4234,
                restart_move = 1
            },
            {
                name = "Jump second hurdle",
                correct_moves = { "feet" },
                incorrect_moves = { "hands" },
                start_frame = 1990,
                end_frame = 2040,
                death_start_frame = 3930,
                death_end_frame = 4234,
                restart_move = 2
            },
            {
                name = "Get in the car, loser.",
                correct_moves = { "hands" },
                incorrect_moves = { "feet" },
                start_frame = 2120,
                end_frame = 2160,
                death_start_frame = 3930,
                death_end_frame = 4234,
                restart_move = 2
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "down" },
                start_frame = 2186,
                end_frame = 2226,
                death_start_frame = 3930,
                death_end_frame = 4234,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 2276,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 7
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 2419,
                end_frame = 2459,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 2447,
                end_frame = 2487,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "hands", "feet", "up" },
                start_frame = 2464,
                end_frame = 2504,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "up", "down", "right" },
                start_frame = 2513,
                end_frame = 2553,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 2549,
                end_frame = 2589,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "feet", "left", "right" },
                start_frame = 2640,
                end_frame = 2680,
                death_start_frame = 3214,
                death_end_frame = 3500,
                restart_move = 7
            },
        }
    },

    -- scene 2
    {
        scene_name = "The Getaway",
        start_frame = 4776,
        end_frame = 8074,
        dunno1_frame = 4592,
        dunno2_frame = 0,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 5186,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5388,
                end_frame = 5428,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "right", "down", "up" },
                start_frame = 5418,
                end_frame = 5458,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 5484,
                end_frame = 5524,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 2
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5516,
                end_frame = 5556,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 5560,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5600,
                end_frame = 5640,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 7
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5680,
                end_frame = 5720,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 7
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5710,
                end_frame = 5750,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 7
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5752,
                end_frame = 5792,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 7
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "feet", "hands", "left", "up", "down" },
                start_frame = 5802,
                end_frame = 5842,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 7
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "feet", "hands" },
                start_frame = 5874,
                end_frame = 5914,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 7
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 5920,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right", "up", "down" },
                start_frame = 6000,
                end_frame = 6040,
                death_start_frame = 9794,
                death_end_frame = 10081,
                restart_move = 14
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 6108,
                end_frame = 6148,
                death_start_frame = 9794,
                death_end_frame = 10081,
                restart_move = 14
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right", "up", "down" },
                start_frame = 6278,
                end_frame = 6318,
                death_start_frame = 9794,
                death_end_frame = 10081,
                restart_move = 14
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 6342,
                end_frame = 6382,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 14
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet", "left", "down" },
                start_frame = 6496,
                end_frame = 6536,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 14
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 6694,
                end_frame = 6734,
                death_start_frame = 10105,
                death_end_frame = 10427,
                restart_move = 14
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right", "up", "down" },
                start_frame = 6904,
                end_frame = 6944,
                death_start_frame = 10105,
                death_end_frame = 10427,
                restart_move = 14
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 6974,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "hands", "feet", "left", "right", "up" },
                start_frame = 7015,
                end_frame = 7055,
                death_start_frame = 10105,
                death_end_frame = 10427,
                restart_move = 22
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right", "up", "down" },
                start_frame = 7114,
                end_frame = 7154,
                death_start_frame = 10105,
                death_end_frame = 10427,
                restart_move = 22
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 7202,
                end_frame = 7242,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 22
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 7239,
                end_frame = 7279,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 22
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 7284,
                end_frame = 7324,
                death_start_frame = 8120,
                death_end_frame = 8409,
                restart_move = 22
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "hands", "left", "right", "up", "down" },
                start_frame = 7403,
                end_frame = 7443,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 22
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 7470,
                end_frame = 7510,
                death_start_frame = 8439,
                death_end_frame = 8732,
                restart_move = 22
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 7958,
                end_frame = 7998,
                death_start_frame = 11753,
                death_end_frame = 12215,
                restart_move = 22
            },
        }
    },

    -- scene 3
    {
        scene_name = "Rooftops",
        start_frame = 12397,
        end_frame = 17248,
        dunno1_frame = 12247,
        dunno2_frame = 0,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 12460,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 12702,
                end_frame = 12742,
                death_start_frame = 17251,
                death_end_frame = 17820,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 12725,
                end_frame = 12765,
                death_start_frame = 17251,
                death_end_frame = 17820,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 13601,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 13866,
                end_frame = 13906,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 13888,
                end_frame = 13918,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 13898,
                end_frame = 13928,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 13944,
                end_frame = 13984,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14044,
                end_frame = 14084,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14256,
                end_frame = 14296,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14343,
                end_frame = 14383,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 5
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 14569,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 14668,
                end_frame = 14708,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 13
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14694,
                end_frame = 14734,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 13
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14788,
                end_frame = 14818,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 13
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 14818,
                end_frame = 14858,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 13
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 15014,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 15143,
                end_frame = 15183,
                death_start_frame = 18596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "up" },
                start_frame = 15221,
                end_frame = 15261,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 15232,
                end_frame = 15272,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 15253,
                end_frame = 15293,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 15270,
                end_frame = 15310,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet", "down" },
                start_frame = 15296,
                end_frame = 15336,
                death_start_frame = 19596,
                death_end_frame = 19889,
                restart_move = 18
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 15750,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet", "down" },
                start_frame = 15884,
                end_frame = 15914,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 16054,
                end_frame = 16094,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 16094,
                end_frame = 16134,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 16137,
                end_frame = 16177,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 16170,
                end_frame = 16210,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 16222,
                end_frame = 16262,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 16254,
                end_frame = 16294,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet", "right" },
                start_frame = 16307,
                end_frame = 16347,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet", "left" },
                start_frame = 16339,
                end_frame = 16379,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 16392,
                end_frame = 16432,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 16424,
                end_frame = 16464,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 16998,
                end_frame = 17038,
                death_start_frame = 18235,
                death_end_frame = 18577,
                restart_move = 25
            },
        }
    },

    -- scene 4
    {
        scene_name = "Highway",
        start_frame = 20891,
        end_frame = 23321,
        dunno1_frame = 20741,
        dunno2_frame = 0,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 21240,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 21553,
                end_frame = 21583,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 21570,
                end_frame = 21600,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 21594,
                end_frame = 21614,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 21640,
                end_frame = 21670,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 21669,
                end_frame = 21699,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 21698,
                end_frame = 21728,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 21727,
                end_frame = 21757,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 21826,
                end_frame = 21856,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 21897,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22004,
                end_frame = 22034,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22050,
                end_frame = 22080,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22065,
                end_frame = 22095,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22097,
                end_frame = 22117,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22102,
                end_frame = 22132,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22146,
                end_frame = 22176,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22160,
                end_frame = 22190,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 11
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22224,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22237,
                end_frame = 22267,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22250,
                end_frame = 22280,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22264,
                end_frame = 22294,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22326,
                end_frame = 22356,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22345,
                end_frame = 22375,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22384,
                end_frame = 22404,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22403,
                end_frame = 22433,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22424,
                end_frame = 22454,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 19
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22492,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet", "left", "right", "down" },
                start_frame = 22494,
                end_frame = 22524,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22500,
                end_frame = 22530,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22538,
                end_frame = 22568,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22556,
                end_frame = 22586,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22580,
                end_frame = 22610,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22592,
                end_frame = 22622,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22610,
                end_frame = 22640,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 28
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22683,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22689,
                end_frame = 22719,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22702,
                end_frame = 22732,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22730,
                end_frame = 22760,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22750,
                end_frame = 22780,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22784,
                end_frame = 22814,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22794,
                end_frame = 22824,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22845,
                end_frame = 22875,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 36
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 22925,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet", "left", "right", "down" },
                start_frame = 22941,
                end_frame = 22971,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 22955,
                end_frame = 22985,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 22995,
                end_frame = 23025,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 23010,
                end_frame = 23040,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 23035,
                end_frame = 23065,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 23046,
                end_frame = 23076,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 23058,
                end_frame = 23088,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 23148,
                end_frame = 23178,
                death_start_frame = 23358,
                death_end_frame = 23640,
                restart_move = 44
            },
        }
    },

    -- scene 5
    {
        scene_name = "The Castle Battle",
        start_frame = 25728,
        end_frame = 26387,
        dunno1_frame = 25579,
        dunno2_frame = 25727,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 25729,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25715,
                end_frame = 25745,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25765,
                end_frame = 25795,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25795,
                end_frame = 25825,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25800,
                end_frame = 25830,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25808,
                end_frame = 25838,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 25824,
                end_frame = 25854,
                death_start_frame = 26423,
                death_end_frame = 26705,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 25931,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 25944,
                end_frame = 25974,
                death_start_frame = 27725,
                death_end_frame = 28014,
                restart_move = 9
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 25996,
                end_frame = 25626,
                death_start_frame = 27725,
                death_end_frame = 28014,
                restart_move = 9
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 26146,
                end_frame = 26176,
                death_start_frame = 27725,
                death_end_frame = 28014,
                restart_move = 9
            },
        }
    },

    -- scene 6
    {
        scene_name = "Finale",
        start_frame = 28514,
        end_frame = 31212,
        dunno1_frame = 28363,
        dunno2_frame = 28510,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 28836,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 28900,
                end_frame = 28930,
                death_start_frame = 31275,
                death_end_frame = 31619,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 29422,
                end_frame = 29452,
                death_start_frame = 31275,
                death_end_frame = 31619,
                restart_move = 2
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 29622,
                end_frame = 29652,
                death_start_frame = 31275,
                death_end_frame = 31619,
                restart_move = 2
            },
            {
                correct_moves = { "hands", "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 30098,
                end_frame = 30128,
                death_start_frame = 31999,
                death_end_frame = 32379,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 30460,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 30794,
                end_frame = 30814,
                death_start_frame = 31999,
                death_end_frame = 32379,
                restart_move = 7
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 30804,
                end_frame = 30834,
                death_start_frame = 31999,
                death_end_frame = 32379,
                restart_move = 7
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 30834,
                end_frame = 30864,
                death_start_frame = 31999,
                death_end_frame = 32379,
                restart_move = 7
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 30890,
                end_frame = 30920,
                death_start_frame = 32399,
                death_end_frame = 32692,
                restart_move = 7
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 30954,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 31063,
                end_frame = 31093,
                death_start_frame = 32797,
                death_end_frame = 33102,
                restart_move = 12
            },
        }
    },

    -- scene 7
    {
        scene_name = "Finale II",
        start_frame = 33255,
        end_frame = 37138,
        dunno1_frame = 33105,
        dunno2_frame = 33252,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 31063,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33668,
                end_frame = 33698,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33704,
                end_frame = 33734,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 33710,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33720,
                end_frame = 33750,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33733,
                end_frame = 33763,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 33760,
                end_frame = 33790,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33824,
                end_frame = 33854,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33830,
                end_frame = 33860,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 33840,
                end_frame = 33870,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 33922,
                end_frame = 33952,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 33938,
                end_frame = 33968,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 33990,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 34030,
                end_frame = 34060,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 14
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 34100,
                end_frame = 34130,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 14
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 34130,
                end_frame = 34160,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 14
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 34286,
                end_frame = 34316,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 14
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 34402,
                end_frame = 34432,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 14
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 34620,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35012,
                end_frame = 35042,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "down" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 35170,
                end_frame = 35200,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35374,
                end_frame = 35404,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35785,
                end_frame = 35815,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35873,
                end_frame = 35903,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35889,
                end_frame = 35919,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 20
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 35955,
                end_frame = 35985,
                death_start_frame = 39727,
                death_end_frame = 40184,
                restart_move = 20
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 36020,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 36164,
                end_frame = 36194,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 28
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 36327,
                end_frame = 36357,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 28
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 36477,
                end_frame = 36507,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 28
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 36593,
                end_frame = 36623,
                death_start_frame = 37192,
                death_end_frame = 37511,
                restart_move = 28
            },
        }
    },

    -- scene 8
    {
        scene_name = "Ending",
        start_frame = 41587,
        end_frame = 46880,
        dunno1_frame = 41436,
        dunno2_frame = 41584,
        moves = {
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 41587,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 41574,
                end_frame = 41604,
                death_start_frame = 46960,
                death_end_frame = 47256,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 41662,
                end_frame = 41692,
                death_start_frame = 46960,
                death_end_frame = 47256,
                restart_move = 2
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 41713,
                end_frame = 41743,
                death_start_frame = 46960,
                death_end_frame = 47256,
                restart_move = 2
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 42550,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 42676,
                end_frame = 42706,
                death_start_frame = 47289,
                death_end_frame = 47578,
                restart_move = 6
            },
            {
                correct_moves = { "up" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 42827,
                end_frame = 42857,
                death_start_frame = 47289,
                death_end_frame = 47578,
                restart_move = 6
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 42860,
                end_frame = 42890,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 6
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 42902,
                end_frame = 42932,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 6
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43068,
                end_frame = 43098,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 6
            },
            {
                correct_moves = { "right" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 43092,
                end_frame = 43102,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 6
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 43163,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43261,
                end_frame = 43291,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43286,
                end_frame = 43306,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43295,
                end_frame = 43325,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43307,
                end_frame = 43337,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43320,
                end_frame = 43350,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43345,
                end_frame = 43375,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43367,
                end_frame = 43397,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43434,
                end_frame = 43464,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43449,
                end_frame = 43479,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43476,
                end_frame = 43506,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43515,
                end_frame = 43545,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43531,
                end_frame = 43561,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43541,
                end_frame = 43571,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43556,
                end_frame = 43586,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43580,
                end_frame = 43610,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43603,
                end_frame = 43633,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43670,
                end_frame = 43700,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43685,
                end_frame = 43715,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43712,
                end_frame = 43742,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43756,
                end_frame = 43786,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43771,
                end_frame = 43801,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43789,
                end_frame = 43819,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43816,
                end_frame = 43846,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43863,
                end_frame = 43893,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43888,
                end_frame = 43908,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43899,
                end_frame = 43929,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 43926,
                end_frame = 43956,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 44151,
                end_frame = 44181,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 44304,
                end_frame = 44334,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 44437,
                end_frame = 44467,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 44530,
                end_frame = 44560,
                death_start_frame = 47607,
                death_end_frame = 47969,
                restart_move = 13
            },
            {
                correct_moves = {},
                incorrect_moves = {},
                start_frame = 45030,
                end_frame = 0,
                death_start_frame = 0,
                death_end_frame = 0,
                restart_move = 1
            },
            {
                correct_moves = { "left" },
                incorrect_moves = { "hands", "feet" },
                start_frame = 45298,
                end_frame = 45328,
                death_start_frame = 48768,
                death_end_frame = 49050,
                restart_move = 45
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 45394,
                end_frame = 45414,
                death_start_frame = 46960,
                death_end_frame = 47256,
                restart_move = 45
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 45525,
                end_frame = 45555,
                death_start_frame = 46960,
                death_end_frame = 47256,
                restart_move = 45
            },
            {
                correct_moves = { "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 45591,
                end_frame = 45621,
                death_start_frame = 49225,
                death_end_frame = 49634,
                restart_move = 45
            },
            {
                correct_moves = { "hands", "feet" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 45618,
                end_frame = 45648,
                death_start_frame = 49225,
                death_end_frame = 49634,
                restart_move = 45
            },
            {
                correct_moves = { "hands" },
                incorrect_moves = { "left", "right", "up", "down" },
                start_frame = 45685,
                end_frame = 45715,
                death_start_frame = 49225,
                death_end_frame = 49634,
                restart_move = 45
            },
        }
    }
}

-- end of cliff.lua ...

