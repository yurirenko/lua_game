return {
  displayInfo = function (fps, mem_usage)
    love.graphics.setColor(228, 59, 68)
    love.graphics.print('FPS: ' .. math.modf(fps), 0, 0)
    love.graphics.print('Mem usage: ' .. math.modf(mem_usage) .. 'Kbytes', 0, 10)
    love.graphics.setColor(225, 225, 225)
  end
}
