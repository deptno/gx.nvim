local function gx()
  local mode = vim.api.nvim_get_mode().mode

  if mode == "n" then
    require('gx/handle_n')()
  elseif mode == "v" or mode == "V" then
    require('gx/handle_v')()
  else
    -- call default handler
    vim.cmd("call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))")
  end
end

---@class Gx
---@field mode 'n'|'v'
---@field handler function
--
--- add handler
--- @param param Gx
local function add(param)
  if param.mode == 'n' then
  end
end
local function setup()
  -- disable default handler
  vim.g.netrw_nogx = 1

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "gx", gx, opts)
  vim.keymap.set("v", "gx", gx, opts)
end

vim.api.nvim_create_user_command("Gx", gx, {})

local M = {}
local __index = {
  setup = setup,
  add = add,
}

setmetatable(M, {
  __index = __index,
})

return M
