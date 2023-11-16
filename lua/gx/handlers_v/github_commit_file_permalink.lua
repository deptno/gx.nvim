local get_git_root = require("gx/lib/get_git_root")
local get_git_remote_info = require("gx/lib/get_git_remote_info")
local get_directory_of_current_file = require("gx/lib/get_directory_of_current_file")
local M = {}

M.handler = function(args)
  local range = args.range
  local cwd = get_directory_of_current_file()
  local git_root = get_git_root(cwd)
  local remote_info = get_git_remote_info(cwd)

  if not remote_info then
    return vim.notify("remote_info is null", vim.log.levels.TRACE)
  end

  local position = #git_root + 2 -- 마지막 / 를 위해 추가
  local file_path = vim.fn.expand("%:p"):sub(position)
  local sha1 = vim.fn.system(string.format("git -C %s rev-parse @", cwd)):gsub("\n", "")

  local domain = remote_info.domain
  local username = remote_info.username
  local repository = remote_info.repository

  local Job = require("plenary.job")
  local command = "open"
  local url

  if range and range[1] then
    if range[3] and range[1] ~= range[3] then
      url = string.format(
        "https://%s/%s/%s/blob/%s/%s#L%s-L%s",
        domain,
        username,
        repository,
        sha1,
        file_path,
        range[1] + 1,
        range[3] + 1
      )
    else
      url =
        string.format("https://%s/%s/%s/blob/%s/%s#L%s", domain, username, repository, sha1, file_path, range[1] + 1)
    end
  else
    url = string.format("https://%s/%s/%s/blob/%s/%s", domain, username, repository, sha1, file_path)
  end

  Job:new({
    command,
    args = {
      url,
    },
  }):sync()

  vim.notify(string.format("Open github permalink: %s", sha1), vim.log.levels.INFO)
end
M.match = function(lines)
  return get_git_root()
end
M.name = "github commit file permalink"

return M
