local Stage = require('src.game.stage')
local Circle = require('src.game.objects.circle')
local Rectangle = require('src.game.objects.rectangle')
local Debug = require('src.game.debug')

local CircleStage = Stage:extend()

local CREATION_PERIOD = 0.001

function CircleStage:new(max_count, max_x, max_y)
  CircleStage.super.new(self)
  self.max_count = max_count
  self.max_x = max_x
  self.max_y = max_y

  self.destroy_handle = nil
end

function CircleStage:createCircles()
  -- for _ = 1, self.max_count, 1 do
  --   local r = Rectangle(
  --     self.area,
  --     love.math.random(0, self.max_x),
  --     love.math.random(0, self.max_y),
  --     love.math.random(0, 2),
  --     love.math.random(0, 3)
  --   )
  --   self.area:addGameObject(r)
  -- end

  for i = 1, self.max_count, 1 do
    self.timer:after(CREATION_PERIOD * i, function ()
      self.area:addGameObject(Circle(
        self.area,
        love.math.random(0, self.max_x),
        love.math.random(0, self.max_y),
        love.math.random(0, 0.6)
      ))
    end)
  end

  self.timer:after(CREATION_PERIOD * self.max_count, function ()
    self.destroy_handle = self.timer:every(love.math.random(0.5, 1), function ()
      if self:getObjectsCount() <= 0 then
        self.timer:cancel(self.destroy_handle)
        self.destroy_handle = nil

        self:createCircles()
        return
      end

      local toDestroy = self.area:getClosestObject(self.max_x / 2, self.max_y / 2, 120, {Rectangle})

      if toDestroy ~= nil then
        toDestroy:kill()
      end
      -- for _, v in pairs(toDestroy) do
      --   v:kill()
      -- end
      -- self.area:getRandomObject():kill()
    end)
  end)
end

return CircleStage
