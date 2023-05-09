local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

require("nvim-treesitter.install").prefer_git = true
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.xquery = {
  install_info = {
    url = "~/projects/grantmacken/tree-sitter-xquery",
    files = { "src/parser.c" },
    branch = "main",
    -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "xquery",
}

-- local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
-- ft_to_parser.someft = "python" -- the someft filetype will use the python parser and queries.

configs.setup({
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "xquery",
  },
  ignore_install = { "erlang" },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  playground = {
    persist_queries = false, -- Whether the query persists across vim sessions
    enable = true,
    updatetime = 25,
  },
  rainbow = {
    enable = true,
  },
  matchup = {
    enable = true, -- mandatory
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

local km = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
km("n", "<F9>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
km("n", "<F10>", "<cmd>write | edit | TSBufEnable highlight<cr>", opts)
km("n", "<F11>", "<cmd>TSPlaygroundToggle<cr>", opts)
