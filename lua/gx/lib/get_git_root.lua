local get_git_root = function(cwd)
  local command = type(cwd) == "string" and string.format("git -C %s rev-parse --show-toplevel", cwd)
    or string.format("git rev-parse --show-toplevel")
  local git_root = vim.fn.system(command):gsub("\n", "")
  local fail_prefix = "fatal:"

  if git_root:sub(1, #fail_prefix) == fail_prefix then
    return nil, git_root
  end

  return git_root, "ok"
end

return get_git_root
