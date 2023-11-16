local get_visual_selection = require("gx/lib/get_visual_selection")
local get_visual_selection_text = require("gx/lib/get_visual_selection_text")
local handlers = require('gx/v')

local handle_v = function()
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

return handle_v
