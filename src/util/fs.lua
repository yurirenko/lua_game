local function get_all_files(path)
  local files = love.filesystem.getDirectoryItems(path)
  local files_table = {}
  for _, item in ipairs(files) do
    local file_name = path .. '/' .. item
    if love.filesystem.isFile(file_name) then
      table.insert(files_table, file_name)
    else
      local nested_files = get_all_files(file_name)
      for _, nested_file in ipairs(nested_files) do
        table.insert(files_table, nested_file)
      end
    end
  end

  return files_table
end

return get_all_files