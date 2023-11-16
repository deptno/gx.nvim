local remove_suffix = require("gx/lib/remove_suffix")

local parse_repository = function(origin)
  local parts = {}

  for part in origin:gmatch("[^@:/]+") do
    table.insert(parts, part)
  end

  local domain = parts[2]
  local username = parts[3]
  local repository = remove_suffix(".git", parts[4])

  return {
    domain = domain,
    username = username,
    repository = repository,
  }
end

return parse_repository
