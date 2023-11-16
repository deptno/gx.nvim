local get_git_branch_info = function()
  local ret = vim.fn.systemlist([=[
git branch -vv | grep -e '^*' | awk '{
  print $2
  while (match($0, /\[[^]]+\]/)) {
    print substr($0, RSTART, RLENGTH)
    gsub(/\[[^]]+\]/, "", $0)
  }
}']=])

  local fail_prefix = "fatal:"

  if ret[1]:sub(1, #fail_prefix) == fail_prefix then
    return nil, ret
  end

  return table.concat(ret, " -> ")
end

return get_git_branch_info
