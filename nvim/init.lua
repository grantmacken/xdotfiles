-- vim:sw=2 fdm=marker
-- {{{ [ disable builtin plugins ]
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

-- }}}

--Remap space as leader key
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup {
  function()
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
      'catppuccin/nvim',
      disable = false,
      as = 'catppuccin',
      config = function()
        require('catppuccin').setup {}
      end,
      startup = function()
        vim.g.catppuccin_flavour = 'frappe' -- latte, frappe, macchiato, mocha
      end,
    }
    use { 'sainnhe/everforest', disable = true }
    use { 'savq/melange', disable = true }
    use {
      'rebelot/kanagawa.nvim',
      disable = false,
      config = function()
        require('kanagawa').setup {
          undercurl = true,
          globalStatus = true,
          transparent = false,
          commentStyle = { italic = true },
        }
      end,
    }

    -- STATUSLINE
    use 'nvim-lualine/lualine.nvim'
    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup {}
      end,
    }
    use {
      'chentoast/marks.nvim',
      event = 'BufReadPre',
      config = function()
        require('marks').setup {}
      end,
    }
    use {
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup {}
      end,
    }
    use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Comment.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }
    -- TELESCOPE
    use 'nvim-telescope/telescope.nvim'
    use {
      'AckslD/nvim-neoclip.lua',
      config = function()
        require('neoclip').setup()
      end,
    }
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    }

    use { 'folke/which-key.nvim' }
    use {
      'lambdalisue/suda.vim',
      cmd = { 'SudaRead', 'SudaWrite' },
      startup = function()
        vim.g.suda_smart_edit = true
      end,
    }
    use { 'tpope/vim-eunuch', cmd = { 'Delete', 'Remove', 'Move', 'Chmod', 'Wall', 'Rename' } }
    use { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } }
     -- use 'romainl/vim-cool'
    use 'mbbill/undotree'
    use 'ThePrimeagen/harpoon'
    --  TREESITTER
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'David-Kunz/treesitter-unit', --test
        'JoosepAlviste/nvim-ts-context-commentstring',
        -- 'andymass/vim-matchup',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/playground',
        -- 'p00f/nvim-ts-rainbow',
      },
    }

    --[[ use {  ]]
    --[[    'williamboman/mason-lspconfig.nvim', ]]
    --[[    config = function() ]]
    --[[      require('mason-lspconfig').setup({ ]]
    --[[      ensure_installed = { 'bashls', 'sumneko_lua','elixirls', 'erlangls', 'jsonls', 'lemminx', 'yamlls', 'cssls' } ]]
    --[[      }) ]]
    --[[    end ]]
    --[[  } ]]
    -- lINTERS AND FORMATTERS
   -- use 'mfussenegger/nvim-lint' -- uses the vim.diagnostic module to present diagnostics in the same way the language client
   --  use 'mhartington/formatter.nvim' -- ./configs/.config/nvim/after/plugin/format.lua --
    -- LSP AND COMPLETIONS PLUGINS

  use { 'L3MON4D3/LuaSnip',
   run = "make install_jsregexp",
   requires = {
  'rafamadriz/friendly-snippets',
   config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,}
  }

 use { 'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {-- lsp
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    {'hrsh7th/nvim-cmp',-- autocompletion
      requires = {
      'L3MON4D3/LuaSnip',  -- Snippets
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets', -- Snippets
      'saadparwaiz1/cmp_luasnip'}}}}
    --[[ use { ]]
    --[[   'VonHeikemen/lsp-zero.nvim', ]]
    --[[   requires = { ]]
    --[[     -- LSP Support ]]
    --[[     { 'neovim/nvim-lspconfig' }, ]]
    --[[     { 'williamboman/mason.nvim' }, ]]
    --[[     { 'williamboman/mason-lspconfig.nvim' }, ]]
    --[[     -- Autocompletion ]]
    --[[     { 'hrsh7th/nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-buffer' }, ]]
    --[[     { 'hrsh7th/cmp-path' }, ]]
    --[[     { 'saadparwaiz1/cmp_luasnip' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lsp' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lua' }, ]]
    --[[     -- Snippets ]]
    --[[     { 'L3MON4D3/LuaSnip' }, ]]
    --[[     { 'rafamadriz/friendly-snippets' }, ]]
    --[[   }, ]]
    --[[ } ]]
    -- local lsp = require('lsp-zero')
    --[[ use { 'neovim/nvim-lspconfig' } -- Collection of configurations for built-in LSP client ]]
    --[[ use { ]]
    --[[   'hrsh7th/nvim-cmp', -- Autocompletion plugin ]]
    --[[   requires = { ]]
    --[[     { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }, -- LSP source for nvim-cmp ]]
    --[[     { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }, -- Snippets source for nvim-cmp ]]
    --[[     { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }, -- Snippets plugin ]]
    --[[     { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-path', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }, ]]
    --[[     { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp' }, ]]
    --[[     { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }, ]]
    --[[     { 'ray-x/cmp-treesitter', after = 'nvim-cmp' }, ]]
    --[[     { 'delphinus/cmp-ctags', after = 'nvim-cmp' }, ]]
    --[[     { 'f3fora/cmp-spell', after = 'nvim-cmp' }, ]]
    --[[   }, ]]
    --[[ } ]]

    --[[     use 'onsails/lspkind-nvim' ]]
    use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight

    -- use {
    --   'vigoux/complementree.nvim',
    --   requires = {
    --     'L3MON4D3/LuaSnip',
    --     'nvim-treesitter/nvim-treesitter',
    --   },
    --   config = function()
    --     local s = require 'complementree.defaults'
    --     local lsp_completion = {
    --      : default = s.lsp,
    --       string = s.ins_completion 'C-F',
    --       comment = s.dummy,
    --     }
    --     require('complementree').setup {
    --       default = s.ins_completion 'C-N',
    --       lua = lsp_completion,
    --     }
    --   end,
    -- }

    -- MARKDOWN
    -- use 'ellisonleao/glow.nvim'
    --TEST
    use 'rcarriga/nvim-notify'
    --https://github.com/stevearc/dressing.nvim
    -- use {
    --   's1n7ax/nvim-window-picker',
    --   tag = 'v1.*',
    --   config = function()
    --     require('window-picker').setup {
    --       autoselect_one = true,
    --       include_current = false,
    --       filter_rules = {
    --         -- filter using buffer options
    --         bo = {
    --           -- if the file type is one of following, the window will be ignored
    --           filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'quickfix' },
    --           -- if the buffer type is one of following, the window will be ignored
    --           buftype = { 'terminal' },
    --         },
    --       },
    --       other_win_hl_color = '#e35e4f',
    --     }
    --   end,
    -- }
    --
    use {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      requires = 'nvim-neo-tree/neo-tree.nvim',
    }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
      },
    }

use({
  "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
})



  end,
  -- {{{ packer config
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  }, -- }}}
}
