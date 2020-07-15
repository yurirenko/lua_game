local GameObject = require('src.game.game_object')

local DrawableGameObject = GameObject:extend()

function DrawableGameObject:new(drawable, area, x, y, opts)
  DrawableGameObject.super.new(self, area, x, y, opts)

  self.drawable = drawable
end

function DrawableGameObject:draw()
  self.drawable:draw()
end

function DrawableGameObject:update(dt)
  self.drawable:update(dt)
end

return DrawableGameObject
