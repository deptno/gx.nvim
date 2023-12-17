---라인 매칭에서 매칭 수행 반환은 url
---@param input string
---@return string|nil
local get_url = function(input)
  local pattern = ".*(https?://%S+).*"

  return input:match(pattern)
end

return get_url
