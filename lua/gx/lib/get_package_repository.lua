local try_read_file = require("gx/lib/try_read_file")

local get_package_repository = function(cwd)
  local f = vim.fn.expand(cwd) .. "/package.json"
  local json = try_read_file(f)

  if json then
    local encoded = vim.fn.json_decode(json)

    if encoded then
      return encoded.repository
    end
  end
end

return get_package_repository
