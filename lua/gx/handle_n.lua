local handlers = require('gx/n')

local handle_n = function()
  local line = vim.api.nvim_get_current_line()
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

return handle_n
