local Room = require('src.game.room')
local Area = require('src.game.area')
local Circle = require('src.game.objects.circle')
local Timer = require('lib.hump.timer')

local Stage = Room:extend()

function Stage:new()
  self.area = Area(self)
  self.timer = Timer()

  self.timer:every(0.02, function ()
    local circle = Circle(
      self.area,
      love.math.random(800),
      love.math.random(600),
      love.math.random(2)
    )
    circle:expand(40, love.math.random(2.3))

    self.area:addGameObject(circle)
    self.timer:after(love.math.random(0.8), function ()
      circle:kill()
    end)
  end)
end

function Stage:update(dt)
  self.timer:update(dt)
  self.area:update(dt)
end

function Stage:draw()
  if self.area ~= nil then
    self.area:draw()
  end
end

return Stage
