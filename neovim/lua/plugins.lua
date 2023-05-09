return {
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
    'mrjones2014/smart-splits.nvim',
    opts = { ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' }, ignored_buftypes = { 'nofile' } },
    build = './kitty/install-kittens.bash',
  },
  { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } },
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
