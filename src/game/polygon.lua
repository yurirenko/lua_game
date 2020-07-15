Timer = require 'lib/hump/timer'

Polygon = Object:extend()

function Polygon:new(vertices)
  -- print(arg)
  for _, v in ipairs(vertices) do
    print(v)
  end
  self.vertices = vertices
end

function Polygon:update(dt)
end

function Polygon:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon('fill', self.vertices)
end
