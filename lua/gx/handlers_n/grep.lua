local handler = function(lines, matched)
  if not pcall(require, "telescope") then
    return vim.notify('fail to require "telescope"')
  end

  vim.cmd(":Telescope live_grep default_text=" .. matched)
end
local match = function(line)
  return vim.fn.expand("<cword>")
end
local name = "grep current word"

return {
  handler = handler,
  match = match,
  name = name,
}
