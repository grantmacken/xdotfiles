return 
{
  { 'nvim-lua/plenary.nvim' },
  -- https://github.com/catppuccin/nvim
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme catppuccin-frappe]]
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    },
    config = function()
      require('bufferline').setup {
        options = {
          -- numbers = "none",
          diagnostics = 'nvim_lsp',
          separator_style = 'slant',
          show_tab_indicators = true,
          show_buffer_close_icons = false,
          show_close_icon = true,
        },
      }
    end,
  },
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = false,
        theme = 'catppuccin-frappe',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
      },
    },
  },

  {
    'mrjones2014/smart-splits.nvim',
    opts = { ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' }, ignored_buftypes = { 'nofile' } },
    build = './kitty/install-kittens.bash',
  },
  { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } },
  {
    "vigoux/notifier.nvim",
    opts =
    {
  ignore_messages = {}, -- Ignore message from LSP servers with this name
  --status_width = something, -- COmputed using 'columns' and 'textwidth'
  components = {  -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
    "nvim",  -- Nvim notifications (vim.notify and such)
    "lsp"  -- LSP status updates
  },
  notify = {
    clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
    min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
  },
  component_name_recall = false, -- Whether to prefix the title of the notification by the component name
  zindex = 50, -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window.
}
}
}

--[[
--
   {
	    'stevearc/overseer.nvim',
	    opts = {},
	    config = {},
	  },
--
--
{
	"stevearc/resession.nvim",
	enabled = true, 
	lazy = true,
	name = 'resession',
	-- opts = {},
	-- config is setup func
	config = {
	  autosave = {
	    enabled = true,
	    interval = 60,
	    notify = true,
	  },
	  options = {
	    "binary",
	    "bufhidden",
	    "buflisted",
	    "cmdheight",
	    "diff",
	    "filetype",
	    "modifiable",
	    "previewwindow",
	    "readonly",
	    "scrollbind",
	    "winfixheight",
	    "winfixwidth",
	  },
	  buf_filter = require("resession").default_buf_filter,
	  dir = "session",
	  load_detail = true,
	  -- Configuration for extensions
	  extensions = {
	    quickfix = {},
	  },
	},
	init = function()
	  local function get_session_name()
	    local name = vim.fn.getcwd()
	    local branch = vim.fn.system("git branch --show-current")
	    if vim.v.shell_error == 0 then
	      return name .. branch
	    else
	      return name
	    end
	  end
	  print(get_session_name())
	  require('resession').load(get_session_name(), { dir = "dirsession", silence_errors = true })
	end
},
]]
--
