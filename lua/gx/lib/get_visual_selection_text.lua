local get_visual_selection = require("gx/lib/get_visual_selection")

---선택된 영역의 text list 를 반환
---v|V 모드는 nil 을 리턴
---@return table|nil
local get_visual_selection_text = function()
  local selection = get_visual_selection()

  if selection then
    local start_line, start_column, end_line, end_column = unpack(selection)

    return vim.api.nvim_buf_get_text(0, start_line, start_column, end_line, end_column, {})
  end
end

return get_visual_selection_text
