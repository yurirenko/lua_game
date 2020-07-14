Object = require 'lib/classic/classic'
Input = require 'lib/boipushy/Input'
Timer = require 'lib/hump/timer'
M = require 'lib/moses/moses'
require 'src/excercise/libs/health_bar'
local require_all = require 'src/util/loader'

local hc = nil
local health_bar = nil
local input = nil
local fps = nil
local timer = nil

local rectangle1 = nil
local rectangle2 = nil

local sum = 0

function love.load()
    require_all('src/game')
    love.window.setMode(800, 600)

    input = Input()
    hc = HyperCircle(400, 300, 50, 10, 120)

    rectangle1 = Rectangle(400, 300, 50, 200)
    rectangle2 = Rectangle(400, 300, 200, 50)

    timer = Timer()

    health_bar = HealthBar(10)

    -- Shrinking cross 
    -- timer:tween(1, rectangle1, {w = 0}, 'in-out-cubic', function ()
    --   timer:tween(1, rectangle2, {h = 0}, 'in-out-cubic', function () 
    --     timer:tween(2, rectangle1, {w = 50}, 'in-out-cubic')
    --     timer:tween(2, rectangle2, {h = 50}, 'in-out-cubic')
    --   end)
    -- end)

    -- Periodic behavior:
    -- Blinking light
    -- timer:after(0, function (f)
    --   timer:tween(6, hc, {radius = 120 - 10}, 'in-out-cubic', function ()
    --     timer:tween(6, hc, {radius = 50}, 'in-out-cubic', function ()
    --       timer:after(0, f)
    --     end)
    --   end)
    -- end)

    -- for i = 1, 10 do
    --   timer:after(0.5 + (i / 2), function () print(love.timer.getTime() .. ': ' .. love.math.random()) end)
    -- end
    input:bind('d', 'damage')
    input:bind('e', 'expand')
    input:bind('s', 'shrink')
    -- input:bind('-', 'add')
end

function love.update(dt)
  timer:update(dt)
  health_bar:update(dt)
  hc:update(dt)

  fps = 1.0/dt
  if input:pressed('damage') then
    health_bar:damage(1.5 * love.math.random())
  end

  if input:pressed('expand') then
    hc:expand(8)
  end

  if input:pressed('shrink') then
    hc:shrink(8)
  end
  -- if input:pressed('test') then
  --   print('pressed')
  -- end
  -- if input:released('test') then
  --   print('released')
  -- end
end

function love.draw()
  hc:draw()
  -- rectangle1:draw()
  -- rectangle2:draw()
  -- health_bar:draw()

  love.graphics.print(fps, 0, 0)
end

-- function love.keypressed(key)
--   print(key)
-- end