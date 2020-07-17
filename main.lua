local Input = require('lib/boipushy/Input')
local Timer = require('lib/hump/timer')
local Debug = require('src.game.debug')
local SquareStage = require('src.excercise.square_stage')
local CircleStage = require('src.excercise.circle_stage')

local SCREEN_WIDTH = 800
local SCREEN_HEIGHT = 600

local fps = nil
local memory_usage = 0

local timer = nil
local current_room = nil
local input = nil

local show_debug_info = false

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    current_room = CircleStage(20, SCREEN_WIDTH, SCREEN_HEIGHT)

    input = Input()
    timer = Timer()

    current_room:createCircles()

    input:bind('`', function () show_debug_info = not show_debug_info end)
    input:bind('d', 'delete_rectangle')
end

local frames_counter = 0
function love.update(dt)
  timer:update(dt)
  fps = 1.0/dt

  current_room:update(dt)
  frames_counter = frames_counter + 1

  if frames_counter > 60 then
    memory_usage = collectgarbage('count')
    frames_counter = 0
  end
end

function love.draw()
  current_room:draw()

  if show_debug_info then
    Debug.displayInfo(fps, memory_usage)
  end
end
