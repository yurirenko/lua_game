Rectangle = Object:extend()

function Rectangle:new(x, y, w, h)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
end

function Rectangle:update(dt)

end

function Rectangle:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', self.x - self.w/2, self.y - self.h/2, self.w, self.h)
end
