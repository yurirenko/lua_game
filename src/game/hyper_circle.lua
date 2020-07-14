require 'src/game/circle'

HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, line_width, outer_radius)
  HyperCircle.super.new(self, x, y, radius)
  self.line_width = line_width
  self.outer_radius = outer_radius
end

function HyperCircle:draw()
  love.graphics.circle('fill', self.x, self.y, self.outer_radius)
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle('fill', self.x, self.y, self.outer_radius - self.line_width)
  love.graphics.setColor(255, 255, 255)
 
  HyperCircle.super.draw(self)
end
