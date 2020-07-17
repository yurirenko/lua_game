local Timer = require('lib.hump.timer')
local Object = require('lib.classic.classic')

local Circle = Object:extend()

function Circle:new(x, y, radius, draw_mode)
  self.x = x
  self.y = y
  self.radius = radius
  self.creation_time = love.timer.getTime()
  self.draw_mode = draw_mode or 'fill'

  self.timer = Timer()
  self.radius_change_handle = nil
end

function Circle:update(dt)
  self.timer:update(dt)
end

function Circle:expand(radius_dt, expansion_time)
  if self.radius_change_handle ~= nil then
    self.timer:cancel(self.radius_change_handle)
  end

  local new_radius = self.radius + radius_dt
  self.radius_change_handle = self.timer:tween(
    expansion_time,
    self,
    {radius = new_radius},
    'in-out-quart'
  )
end

function Circle:shrink(radius_dt)
  if self.radius_change_handle ~= nil then
    self.timer:cancel(self.radius_change_handle)
  end

  local new_radius = self.radius - radius_dt
  self.radius_change_handle = self.timer:tween(0.8, self, {radius = new_radius}, 'in-out-quart')
end

function Circle:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle(self.draw_mode, self.x, self.y, self.radius)
end

return Circle
