local get_url = require("gx/lib/get_url")
local handler = function(line, matched)
  local os = vim.loop.os_uname().sysname
  if vim.loop.os_uname().sysname ~= "Darwin" then
    return vim.notify("unsupported os: " .. os, vim.log.levels.WARN)
  end

  local command = string.format([[open '%s']], matched)
  vim.fn.system(command)
  vim.notify(command)
end
local match = get_url
local name = "url"

return {
  handler = handler,
  match = match,
  name = name,
}
