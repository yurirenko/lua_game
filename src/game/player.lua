local DrawableGameObject = require('src.game.drawable_game_object')
local ShootEffect = require('src.game.objects.shoot_effect')
local Circle = require('src.game.drawable_shapes.circle')

local Player = DrawableGameObject:extend()

function Player:new(area, x, y)
  self.r = -math.pi/2

  self.rv = 1.66 * math.pi
  self.v = 0
  self.max_v = 100
  self.a = 100

  self.w, self.h = 12, 12

  local drawable = Circle(x, y, self.w, 'line')
  Player.super.new(self, drawable, area, x, y)

  self.collider = self.area.world:newCircleCollider(self.x, self.y, self.w)
  self.collider:setObject(self)

  self.timer:every(0.24, function ()
    self:shoot()
  end)
end

function Player:update(dt, input)
  Player.super.update(self, dt)

  if input:down('left') then
    self.r = self.r - self.rv * dt
  end
  if input:down('right') then
    self.r = self.r + self.rv * dt
  end
  if input:down('shoot') then
    self:shoot()
  end
  self.v = math.min(self.v + self.a * dt, self.max_v)

  self.collider:setLinearVelocity(
    self.v * math.cos(self.r),
    self.v * math.sin(self.r)
  )
end

function Player:draw()
  Player.super.draw(self)

  love.graphics.line(
    self.x,
    self.y,
    self.x + math.cos(self.r) * 20,
    self.y + math.sin(self.r) * 20
  )
end

function Player:shoot()
  local d = 1.2 * self.w

  self.area:addGameObject(ShootEffect(
    self,
    d,
    self.area,
    self.x + d * math.cos(self.r),
    self.y + d * math.sin(self.r)
  ))
end

return Player
