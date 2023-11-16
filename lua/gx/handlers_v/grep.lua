local trim = require("gx/lib/trim")
local M = {}

M.handler = function(args)
  local matched = M.match(args.lines)
  if not pcall(require, "telescope") then
    return vim.notify('fail to require "telescope"')
  end

  vim.cmd(":Telescope live_grep default_text=" .. matched)
end
M.match = function(lines)
  if #lines == 1 then
    local line = lines[1]

    if line:gmatch("%w+") then
      return trim(line)
    end
  end

  return nil
end
M.name = "grep text"

return M
