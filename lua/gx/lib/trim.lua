---trim string
---@param text string
---@return string
local trim = function(text)
  return text:match([[^%s*(.-)%s*$]])
end

return trim
