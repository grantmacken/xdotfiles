local ok, harpoon = pcall(require, 'harpoon')
if not ok then
  return
end

harpoon.setup {
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
    excluded_filetypes = { 'harpoon' },
  },
  projects = {
    ['$HOME/projects/grantmacken/podx'] = {
      term = {
        cmds = {
          'podman ps',
        },
      },
    },
  },
}

local opts = { noremap = true, silent = true }
local km = vim.api.nvim_set_keymap
-- HARPOON
km('n', '<leader>a', [[<cmd>lua require("harpoon.mark").add_file()<CR>]], opts)
km('n', '<leader>m', [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], opts)
km('n', '<leader>c', [[<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>]], opts)

-- km('n', '<leader>gt', [[<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>]], opts)
km('n', '<A-m>', [[<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>]], opts)
km('n', '<A-t>', [[<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>]], opts)
km('n', '<A-1>', [[<cmd>lua require("harpoon.term").sendCommand(1,1)<CR>]], opts)
