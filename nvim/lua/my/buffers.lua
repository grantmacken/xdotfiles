local M = {}

M.quickfix_toggle = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.api.nvim_command('cclose')
      return
    end
  end
  vim.api.nvim_command('copen')
end

M.scratch = function()
local NuiLine = require("nui.line")
local line = NuiLine()
local Split = require("nui.split")
local event = require('nui.utils.autocmd').event
local split = Split({
    ns_id = 'scratch',
    relative = 'editor',
    position = 'bottom',
    enter = false,
    size = '20%',
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = 'no' },
    buf_options = {
      bufhidden = "hide",
      buflisted = false,
      buftype = "nofile",
      swapfile = false,
    },
  })

 --  split:mount()
 --  split:on( event.BufLeave, function() split:unmount() end)

  -- line:append("Something Went Wrong!", "Error")
  -- line:render(split.bufnr, split.ns_id, 1)

end

return M
