return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  keys = [[<c-\>]],
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 10
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
  },

  config = function(_, opts)
    local toggleterm = require 'toggleterm'
    toggleterm.setup(opts)
  end,
}
