local DrawableGameObject = require('src.game.drawable_game_object')
local DrawableCircle = require('src.game.drawable_shapes.circle')

local Circle = DrawableGameObject:extend()

function Circle:new(area, x, y, radius, draw_mode)
  local drawable = DrawableCircle(x, y, radius, draw_mode)

  Circle.super.new(self, drawable, area, x, y)
end

function Circle:expand(radius_dt, expansion_time)
  self.drawable:expand(radius_dt, expansion_time)
end

return Circle
