Object = require 'lib/classic/classic'
Input = require 'lib/boipushy/Input'
Timer = require 'lib/hump/timer'
M = require 'lib/moses/moses'
UUID = require 'lib/uuid/uuid'
local Stage = require('src.game.stage')
require 'src/excercise/libs/health_bar'


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
