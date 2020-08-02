local DrawableGameObject = require('src.game.drawable_game_object')
local Rectangle = require('src.game.drawable_shapes.rectangle')

local ShootEffect = DrawableGameObject:extend()

function ShootEffect:new(player, d, area, x, y)
  local drawable = Rectangle(x, y, 8, 8)

  ShootEffect.super.new(
    self,
    drawable,
    area,
    x,
    y
  )

  self.player = player
  self.d = d

  self.timer:tween(0.1, self.drawable, {w = 0, h = 0}, 'in-out-cubic', function ()
    self:kill()
  end)
end

function ShootEffect:update(dt)
  ShootEffect.super.update(self, dt)

  if self.player then
    self.x = self.player.x + self.d * math.cos(self.player.r)
    self.y = self.player.y + self.d * math.sin(self.player.r)
  end
end

function ShootEffect:draw()
  ShootEffect.super.pushRotate(self, self.x, self.y, self.player.r + math.pi / 4)
  ShootEffect.super.draw(self)
  love.graphics.pop()
end

return ShootEffect
