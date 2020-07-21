local Input = require('lib.boipushy.Input')
local Timer = require('lib.hump.timer')
local Debug = require('src.game.debug')
local Stage = require('src.game.stage')
require('lib.windfield.windfield')

local Camera = require('lib.hump.camera')

local fps = nil
local memory_usage = 0

local timer = nil
local current_room = nil
local input = nil

local show_debug_info = false

function resize(s)
  love.window.setMode(s * BASE_RESOLUTION_W, s * BASE_RESOLUTION_H)

  RESOLUTION_SCALE_X, RESOLUTION_SCALE_Y = s, s
end

local camera = nil

function love.load()
    resize(2)

    love.graphics.setDefaultFilter('nearest')
    love.graphics.setLineStyle('rough')

    input = Input()
    timer = Timer()

    camera = Camera()
    current_room = Stage(camera)
    input:bind('p', function ()
      camera:shake(4, 60, 1) end
    )

    input:bind('`', function () show_debug_info = not show_debug_info end)
    input:bind('d', 'delete_rectangle')

    input:bind('left', 'left')
    input:bind('right', 'right')
end

local frames_counter = 0
function love.update(dt)
  timer:update(dt)
  camera:update(dt)

  current_room:update(dt, input)

  fps = 1.0/dt
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
