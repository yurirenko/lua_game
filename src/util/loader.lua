local get_all_files = require('src/util/fs')

local function require_all(path)
  local files = get_all_files(path)
  for _, file in ipairs(files) do
    local extension = file:sub(-3, -1)
    if extension == 'lua' then
      require(file:sub(1, -5))
    end
  end
end

return require_all
