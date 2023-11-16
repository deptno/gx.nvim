---map table<a> to table<b>
---@param fn function(a):b
---@param tlb table
---@return table
local map = function(fn, tlb)
  assert(type(fn) == "function", "fn: function")
  assert(type(tlb) == "table", "tlb: table(list)")

  local ret = {}

  for _, v in ipairs(tlb) do
    table.insert(ret, fn(v))
  end

  return ret
end

return map
