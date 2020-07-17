local DrawableGameObject = require('src.game.drawable_game_object')
local DrawableRectangle = require('src.game.drawable_shapes.rectangle')

local Rectangle = DrawableGameObject:extend()

function Rectangle:new(area, x, y, w, h)
  local drawable = DrawableRectangle(x, y, w, h)

  Rectangle.super.new(self, drawable, area, x, y)
end

return Rectangle
