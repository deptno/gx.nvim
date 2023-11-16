local remove_suffix = function(suffix, name)
  if name:sub(-#suffix) == suffix then
    return name:sub(1, -(#suffix + 1))
  end
  return name
end

return remove_suffix
