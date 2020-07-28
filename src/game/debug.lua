local inspect = require('lib.inspect.inspect')

local function remove_all_metatables(item, path)
  if path[#path] ~= inspect.METATABLE then return item end
end

return {
  displayInfo = function (fps, mem_usage)
    love.graphics.setColor(228, 59, 68)
    love.graphics.print('FPS: ' .. math.modf(fps), 0, 0)
    love.graphics.print('Mem usage: ' .. math.modf(mem_usage) .. 'Kbytes', 0, 10)
    love.graphics.setColor(225, 225, 225)
  end,
  print_all = function (anything, max_depth)
    max_depth = max_depth or 5
    print(inspect(anything, {depth = max_depth, process = remove_all_metatables}))
  end
}
