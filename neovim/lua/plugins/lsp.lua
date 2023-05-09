return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset {}
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        keys = function()
          return {}
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/nvim-cmp',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
      require('lsp-zero.cmp').extend()
      -- And you can configure cmp even more, if you want to.
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end
      local cmp_action = require('lsp-zero.cmp').action()
      cmp.setup {
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        },
        mapping = {
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
      }
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'williamboman/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {
            'awk_ls',
            'bashls',
            'cssls',
            'erlangls',
            'eslint',
            'grammarly',
            'html',
            'jsonls',
            'lemminx',
            'lua_ls',
            'prosemd_lsp',
            'yamlls',
          },
        },
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'jay-babu/mason-null-ls.nvim' },
      },
      --
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            border = 'rounded',
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
        build = function()
          vim.cmd 'MasonUpdate'
        end,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require 'lsp-zero'

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps { buffer = bufnr }
      end)

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.format_on_save {
        format_opts = {
          timeout_ms = 10000,
        },
        servers = {
          ['null-ls'] = { 'javascript', 'lua' },
        },
      }

      lsp.setup()
      local nls = require 'null-ls'
      nls.setup {
        root_dir = require('null-ls.utils').root_pattern('Makefile', '.git'),
        sources = {
          nls.builtins.formatting.stylua,
        },
      }
      require('mason-null-ls').setup {
        ensure_installed = {
          'shfmt',
          'stylua',
          'jq',
          'prettierd',
          'eslint',
        },
        automatic_installation = false,
        handlers = {},
      }
    end,
  },
}
