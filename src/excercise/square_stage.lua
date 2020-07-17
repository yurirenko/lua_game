local M = require('lib.moses.moses')
local Stage = require('src.game.stage')
local Rectangle = require('src.game.objects.rectangle')
local inspect = require('lib.inspect.inspect')

local SquareStage = Stage:extend()

function SquareStage:new(max_count, max_x, max_y)
  SquareStage.super.new(self)

  self.rectangle_count = 0
  self.max_count = max_count
  self.max_x = max_x
  self.max_y = max_y
end

function SquareStage:createRectangles()
    for _ = 1, self.max_count, 1 do
      local r = Rectangle(
        self.area,
        love.math.random(0, self.max_x),
        love.math.random(0, self.max_y),
        love.math.random(0, 40),
        love.math.random(0, 60)
      )
      self.area:addGameObject(r)
    end
end

function SquareStage:deleteRandomRectangle()
  if #self.area.game_objects <= 0 then
    return
  end

  self.area:getRandomObject():kill()
end

return SquareStage
