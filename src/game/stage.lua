local Timer = require('lib.hump.timer')
local Camera = require('lib.hump.camera')

local Area = require('src.game.area')
local Room = require('src.game.room')
local Player = require('src.game.player')

local Stage = Room:extend()

function Stage:new(camera)
  self.area = Area(self)
  self.area:addPhysicsWorld()

  self.timer = Timer()
  self.camera = camera

  self.main_canvas = love.graphics.newCanvas(BASE_RESOLUTION_W, BASE_RESOLUTION_H)
  self.player = self.area:addGameObject(
    Player(self.area, BASE_RESOLUTION_W / 2, BASE_RESOLUTION_H / 2)
  )
end

function Stage:update(dt, input)
  self.camera.smoother = Camera.smooth.damped(5)
  self.camera:lockPosition(dt, BASE_RESOLUTION_W / 2, BASE_RESOLUTION_H / 2)

  if input:pressed('kill_player') then
    self.player:kill()
  end

  self.timer:update(dt)
  self.area:update(dt, input)
end

function Stage:draw()
  if self.area ~= nil then
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()

    self.camera:attach(0, 0, BASE_RESOLUTION_W, BASE_RESOLUTION_H)
    self.area:draw()
    self.camera:detach()
    love.graphics.setCanvas()

    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, RESOLUTION_SCALE_X, RESOLUTION_SCALE_Y)
    love.graphics.setBlendMode('alpha')
  end
end

function Stage:getObjectsCount()
  return #self.area.game_objects
end

function Stage:destroy()
  self.area:destroy()
  self.area = nil
  self.camera = nil
  self.timer = nil
  self.main_canvas = nil
end

return Stage
