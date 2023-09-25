local M = {}

local get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system 'git branch --show-current'
  if vim.v.shell_error == 0 then
    return name .. '#' .. branch
  else
    return name
  end
end

M.get_session_name = get_session_name

return M
