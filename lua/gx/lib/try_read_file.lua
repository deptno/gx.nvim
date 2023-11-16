local file_exists = require("gx/lib/file_exists")

local function try_read_file(file)
  if not file_exists(file) then
    return nil
  end

  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end

  return table.concat(lines)
end

return try_read_file
