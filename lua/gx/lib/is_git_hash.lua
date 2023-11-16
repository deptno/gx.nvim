local is_git_hash = function(hash)
  local char = "[0-9a-fA-F]"
  local matched = string.match(hash, string.format("%s*", char:rep(8)))

  return matched ~= nil and #matched <= 40 and matched
end

return is_git_hash
