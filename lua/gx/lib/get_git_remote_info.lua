local parse_repository = require("custom/lib/parse_repository")

local get_git_remote_info = function(cwd)
  local command = type(cwd) == "string" and string.format("git -C %s remote -v | head -1 | awk '{print $2}'", cwd)
    or "git remote -v | head -1 | awk '{print $2}'"
  local origin = vim.fn.system(command):gsub("\n", "")
  local fail_prefix = "fatal:"

  if origin:sub(1, #fail_prefix) == fail_prefix then
    return nil, origin
  end

  return parse_repository(origin)
end

return get_git_remote_info
