local Input = require 'lib/boipushy/Input'
local Timer = require 'lib/hump/timer'
local Stage = require('src.game.stage')


local fps = nil
local timer = nil
local current_room = nil
local input = nil

function love.load()
    love.window.setMode(800, 600)
    current_room = Stage()

    input = Input()
    timer = Timer()
end

function love.update(dt)
  timer:update(dt)
  fps = 1.0/dt

  current_room:update(dt)
end

function love.draw()
  love.graphics.print(math.modf(fps), 0, 0)

  current_room:draw()
end
