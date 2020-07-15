local Object = require('lib.classic.classic')
local Timer = require 'lib/hump/timer'
local UUID = require('lib.uuid.uuid')

local GameObject = Object:extend()

function GameObject:new(area, x, y, opts)
  local opts = opts or {}
  if opts then
    for k, v in pairs(opts) do
      self[k] = v
    end
  end

  self.area = area
  self.x, self.y = x, y
  self.id = UUID()
  self.dead = false
  self.timer = Timer()
end

function GameObject:update(dt)
  if self.timer then
    self.timer:update(dt)
  end
end

function GameObject:draw()
end

function GameObject:kill()
  self.dead = true
end

return GameObject