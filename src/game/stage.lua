local Room = require('src.game.room')
local Area = require('src.game.area')
local Timer = require('lib.hump.timer')

local Stage = Room:extend()

function Stage:new()
  self.area = Area(self)
  self.timer = Timer()
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

function Stage:getObjectsCount()
  return #self.area.game_objects
end

return Stage
