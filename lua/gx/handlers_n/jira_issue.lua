local handler = function(line, matched)
  local Job = require("plenary.job")
  local command = "open"

  Job:new({
    command,
    args = {
      "https://zigbang.atlassian.net/browse/" .. matched,
    },
  }):sync()

  vim.notify(string.format("Open ticket: %s", matched), vim.log.levels.INFO)
end
local match = function(line)
  return string.match(line, "B2C%-%d+")
end
local name = "jira-issue"

return {
  handler = handler,
  match = match,
  name = name,
}
