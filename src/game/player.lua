local GameObject = require('src.game.game_object')

local Player = GameObject:extend()

function Player:new(area, x, y)
  Player.super.new(self, area, x, y)

  self.r = -math.pi/2
  self.rv = 1.66 * math.pi
  self.v = 0
  self.max_v = 100
  self.a = 100

  self.w, self.h = 12, 12

  self.collider = self.area.world:newCircleCollider(self.x, self.y, self.w)
  self.collider:setObject(self)
end

function Player:update(dt, input)
  Player.super.update(self, dt)

  if input:down('left') then
    self.r = self.r - self.rv * dt
  end
  if input:down('right') then
    self.r = self.r + self.rv * dt
  end
  self.v = math.min(self.v + self.a * dt, self.max_v)

  self.collider:setLinearVelocity(
    self.v * math.cos(self.r),
    self.v * math.sin(self.r)
  )
end

function Player:draw()
  love.graphics.circle('line', self.x, self.y, self.w)
  love.graphics.line(
    self.x,
    self.y,
    self.x + math.cos(self.r) * 20,
    self.y + math.sin(self.r) * 20
  )
end

return Player
