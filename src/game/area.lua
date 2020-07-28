local Object = require('lib.classic.classic')
local windfield = require('lib.windfield.windfield')
local M = require('lib.moses.moses')

local Area = Object:extend()

local function inCircleWithTypePredicate(x, y, radius, types)
  local in_circle = false
  types = types or {}

  return (function (v)
    in_circle = ((v.x - x) ^ 2) + ((v.y - y) ^ 2) < radius * radius
    if not in_circle then
      return false
    end

    if #types == 0 then
      return true
    end

    for _, type in pairs(types) do
      if v:is(type) then
        return true
      end
    end

    return false
  end)
end

function Area:new(room)
  self.room = room
  self.game_objects = {}
end

function Area:addGameObject(game_object)
  table.insert(self.game_objects, game_object)

  return game_object
end

function Area:addPhysicsWorld()
  self.world = windfield.newWorld(0, 0, true)
end

function Area:getGameObjects(predicate)
  return M.filter(self.game_objects, predicate)
end

function Area:findGameObject(predicate)
  local index = M.findIndex(self.game_objects, predicate)
  if index then
    return self.game_objects[index]
  else
    return nil
  end
end

function Area:getRandomObject()
  return self.game_objects[love.math.random(#self.game_objects)]
end

function Area:queryCircleArea(x, y, radius, types)
  types = types or {}

  return self:getGameObjects(inCircleWithTypePredicate(x, y, radius, types))
end

function Area:getClosestObject(x, y, radius, types)
  types = types or {}

  return self:findGameObject(inCircleWithTypePredicate(x, y, radius, types))
end

function Area:update(dt, input)
  if self.world then
    self.world:update(dt)
  end

  for i = #self.game_objects, 1, -1 do
    local game_object = self.game_objects[i]
    game_object:update(dt, input)

    if game_object.dead then
      game_object:destroy()
      table.remove(self.game_objects, i)
    end
  end
end

function Area:draw()
  if self.world then
    self.world:draw()
  end

  for _, game_object in pairs(self.game_objects) do
    game_object:draw()
  end
end

function Area:destroy()
  for i = #self.game_objects, 1, -1 do
    local game_object = self.game_objects[i]
    game_object:destroy()
    table.remove(self.game_objects, i)
  end

  self.game_objects = {}
  if self.world then
    self.world:destroy()
    self.world = nil
  end
  self.room = nil
end

return Area
