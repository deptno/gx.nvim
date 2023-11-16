local get_visual_selection = require("gx/lib/get_visual_selection")
local get_visual_selection_text = require("gx/lib/get_visual_selection_text")
local handle_n = function()
  local line = vim.api.nvim_get_current_line()
  local handlers = require("gx/handlers_n")
  local matched_handlers = {}

  for _, h in ipairs(handlers) do
    if h.match(line) then
      table.insert(matched_handlers, h)
    end
  end

  if #matched_handlers == 1 then
    local matched_handler = matched_handlers[#matched_handlers]

    matched_handler.handler(line, matched_handler.match(line))
  elseif #matched_handlers > 1 then
    vim.ui.select(matched_handlers, {
      prompt = "handlers:",
      format_item = function(h)
        return h.name
      end,
    }, function(selected)
      selected.handler(line, selected.match(line))
    end)
  end
end
local handle_vV = function()
  local handlers = require("gx/handlers_v")
  local range = get_visual_selection()
  local lines = get_visual_selection_text()
  local matched_handlers = {}

  for _, h in ipairs(handlers) do
    if h.match(lines) then
      table.insert(matched_handlers, h)
    end
  end

  if #matched_handlers == 1 then
    local matched_handler = matched_handlers[#matched_handlers]

    matched_handler.handler({ range = range, lines = lines })
  elseif #matched_handlers > 1 then
    vim.ui.select(matched_handlers, {
      prompt = "handlers:",
      format_item = function(h)
        return h.name
      end,
    }, function(selected)
      selected.handler({ range = range, lines = lines })
    end)
  end
end
local function gx()
  local mode = vim.api.nvim_get_mode().mode

  if mode == "n" then
    handle_n()
  elseif mode == "v" or mode == "V" then
    handle_vV()
  else
    -- call default handler
    vim.cmd("call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))")
  end
end
-- tests
-- B2C-33333
-- 464814b135043ea99138f4d32c8f5df702f7a436

local function setup()
  -- disable default handler
  vim.notify("~~~")
  vim.g.netrw_nogx = 1

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "gx", gx, opts)
  vim.keymap.set("v", "gx", gx, opts)
end

vim.api.nvim_create_user_command("Gx", gx, {})

setup()

local M = {}

setmetatable(M, {
  __index = function() end,
})

return M
