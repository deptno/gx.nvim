local map = require("gx/lib/map")
local trim = require("gx/lib/trim")
local M = {}

M.handler = function(args)
  local matched = M.match(args.lines)
  local Job = require("plenary.job")
  local command = "open"
  local url = string.format("https://papago.naver.com/?sk=en&tk=ko&hn=1&st=%s", matched)

  Job:new({
    command,
    args = {
      url,
    },
  }):sync()

  vim.notify(string.format("Open papago: %s", matched), vim.log.levels.INFO)
end
M.match = function(lines)
  for _, line in ipairs(lines) do
    if line:gmatch("%w+") then
      return trim(table.concat(map(trim, lines), " "))
    end
  end

  return nil
end
M.name = "translator:papago"

return M
