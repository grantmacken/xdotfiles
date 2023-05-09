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

M.my_terms = {}
--- Toggle a user terminal if it exists, if not then create a new one and save it
---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
local toggle_term_cmd = function(opts)
  local terms = M.my_terms
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == 'string' then
    opts = { cmd = opts, hidden = true }
  end
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then
    terms[opts.cmd] = {}
  end
  if not terms[opts.cmd][num] then
    if not opts.count then
      opts.count = vim.tbl_count(terms) * 100 + num
    end
    if not opts.on_exit then
      opts.on_exit = function()
        terms[opts.cmd][num] = nil
      end
    end
    terms[opts.cmd][num] = require('toggleterm.terminal').Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

M.get_session_name = get_session_name
M.toggle_term_cmd = toggle_term_cmd

return M
