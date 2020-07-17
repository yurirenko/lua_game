local Object = require('lib.classic.classic')
local M = require('lib.moses.moses')

local Area = Object:extend()

function Area:new(room)
  self.room = room
  self.game_objects = {}
end

function Area:addGameObject(game_object)
  table.insert(self.game_objects, game_object)

  return game_object
end

function Area:getGameObjects(predicate)
  return M.filter(self.game_objects, predicate)
end

function Area:getRandomObject()
  return self.game_objects[love.math.random(#self.game_objects)]
end

function Area:update(dt)
  for i = #self.game_objects, 1, -1 do
    local game_object = self.game_objects[i]
    game_object:update(dt)

    if game_object.dead then
      table.remove(self.game_objects, i)
    end
  end
end

function Area:draw()
  for i, game_object in pairs(self.game_objects) do
    game_object:draw()
  end
end

return Area
