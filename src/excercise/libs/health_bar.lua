require 'src/game/rectangle'
Timer = require 'lib/hump/timer'

HealthBar = Rectangle:extend()

local pix_per_health = 22

local main_color = {238, 107, 101}
local tint_color = {206, 78, 72}

function HealthBar:new(max_health)
  self.health = max_health

  self.x = 400
  self.y = 300

  self.w = max_health * pix_per_health
  self.tint_width = max_health
  self.h = 50

  self.timer = Timer()
  self.health_animation_handle = nil
  self.tint_animation_handle = nil
end

function HealthBar:update(dt)
  self.timer:update(dt)
end

function HealthBar:damage(damage)
  if self.health <= 0 then
    return
  end

  if self.tint_animation_handle ~= nil then
    self.timer:cancel(self.tint_animation_handle)
  end
  if self.health_animation_handle ~= nil then
    self.timer:cancel(self.health_animation_handle)
  end

  local new_health = self.health - damage
  if new_health < 0 then
    new_health = 0
  end

  self.health_animation_handle = self.timer:tween(0.4, self, {health = new_health}, 'in-out-quart', function ()
    self.tint_animation_handle = self.timer:tween(0.4, self, {tint_width = self.health}, 'in-out-quad')
  end)
end

function HealthBar:draw()
  love.graphics.setColor(tint_color)
  love.graphics.rectangle(
    'fill',
    self.x - self.w/2,
    self.y - self.h/2,
    self.tint_width * pix_per_health,
    self.h
  )
  love.graphics.setColor(main_color)
  print(' bar width: ' .. self.health * pix_per_health)
  love.graphics.rectangle(
    'fill',
    self.x - self.w/2,
    self.y - self.h/2,
    self.health * pix_per_health,
    self.h
  )
  love.graphics.setColor(255, 255, 255)
end
