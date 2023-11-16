local get_git_root = require("gx/lib/get_git_root")
local get_directory_of_current_file = require("gx/lib/get_directory_of_current_file")
local parse_repository = require("gx/lib/parse_repository")
local get_package_repository = require("gx/lib/get_package_repository")
local M = {}

M.handler = function(args)
  local remote_info = M.match(args.lines)
  if not remote_info then
    return vim.notify(string.format("remote_info is nil"), vim.log.levels.ERROR)
  end

  local domain = remote_info.domain
  local username = remote_info.username
  local repository = remote_info.repository

  local Job = require("plenary.job")
  local command = "open"
  local url = string.format("https://%s/%s/%s", domain, username, repository)

  Job:new({
    command,
    args = {
      url,
    },
  }):sync()

  vim.notify(string.format("Open url: %s", url), vim.log.levels.INFO)
end
M.match = function(lines)
  local cwd = get_directory_of_current_file()
  local cwd_expanded = vim.fn.expand(cwd)
  local git_root = get_git_root(cwd)
  local pattern = vim.fn.expand(git_root):gsub("-", "%%-") .. "/node_modules/[%w%-_]+"
  local package_in_node_modules = cwd_expanded:match(pattern)

  if not package_in_node_modules then
    return
  end

  local package_repo = get_package_repository(package_in_node_modules)
  if not package_repo then
    return
  end

  return parse_repository(package_repo)
end
M.name = "open package repository"

return M
