local handler = function(lines, matched)
  if not pcall(require, "telescope") then
    return vim.notify('fail to require "telescope"')
  end

  vim.cmd(":Telescope find_files default_text=" .. matched)
end
local match = function(line)
  return vim.fn.expand("<cword>")
end
local name = "find files including current word"

return {
  handler = handler,
  match = match,
  name = name,
}
