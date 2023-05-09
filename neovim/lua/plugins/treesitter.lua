return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects', -- TODO
    'HiPhish/nvim-ts-rainbow2',
    'andymass/vim-matchup',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    require('nvim-treesitter.install').prefer_git = true
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.xquery = {
      install_info = {
        url = '~/projects/grantmacken/tree-sitter-xquery',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'xquery',
    }
  end,
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    --indent = { enable = true },
    --context_commentstring = { enable = true, enable_autocmd = false },
    ensure_installed = {
      'bash',
      'css',
      'html',
      'javascript',
      'json',
      'lua',
      'query',
      'regex',
      'yaml',
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
    rainbow = {
      enable = true,
    },
    matchup = {
      enable = true, -- mandatory
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require('nvim-treesitter.configs').setup(opts)
  end,
}
