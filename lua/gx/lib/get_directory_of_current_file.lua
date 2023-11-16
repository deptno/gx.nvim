local get_directory_of_current_file = function()
  return vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":~")
end

return get_directory_of_current_file
