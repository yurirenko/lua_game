local GameObject = require('src.game.game_object')

local DrawableGameObject = GameObject:extend()

function DrawableGameObject:new(drawable, area, x, y)
  DrawableGameObject.super.new(self, area, x, y)

  self.drawable = drawable
end

function DrawableGameObject:draw()
  self.drawable:draw()
end

function DrawableGameObject:update(dt)
  DrawableGameObject.super.update(self, dt)

  self.drawable:update(dt)

  self.drawable.x = self.x
  self.drawable.y = self.y
end

function DrawableGameObject:destroy()
  DrawableGameObject.super.destroy(self)

  self.drawable = nil
end

function DrawableGameObject:pushRotate(x, y, r)
  love.graphics.push()
  love.graphics.translate(x, y)
  love.graphics.rotate(r or 0)
  love.graphics.translate(-x, -y)
end

return DrawableGameObject
