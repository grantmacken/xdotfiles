return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
      opts = {
        -- options for vim.diagnostic.config()
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
          -- Be aware that you also will need to properly configure your LSP server to
          -- provide the inlay hints.
          inlay_hints = {
            enabled = false,
          },
          -- add any global capabilities here
          capabilities = {},
          -- Automatically format on save
          autoformat = true,
          -- Enable this to show formatters used in a notification
          -- Useful for debugging formatter issues
          format_notify = false,
          -- options for vim.lsp.buf.format
          -- `bufnr` and `filter` is handled by the LazyVim formatter,
          -- but can be also overridden when specified
          format = {
            formatting_options = nil,
            timeout_ms = nil,
          },
        },
        -- LSP Server Settings
        servers = {
          jsonls = {},
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          },
        },
      },
      setup = {},
      config = function(_, opts)
        local lspconfig = require('lspconfig')

        -- cmp as a lsp default capability
        -- TODO don't do this but check capabilty then add capability? 
        local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_defaults = lspconfig.util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend('force',lsp_defaults.capabilities, cmp_capabilities)
        local default_setup = function(server)
          lspconfig[server].setup({})
        end
        require('mason').setup({})
        require('mason-lspconfig').setup({
          ensure_installed = {},
          handlers = {
            default_setup,
            lua_ls = function()
              require('lspconfig').lua_ls.setup({
                settings = {
                  Lua = {
                    runtime = {
                      version = 'LuaJIT'
                    },
                    diagnostics = {
                      globals = {'vim'},
                    },
                    workspace = {
                      library = {
                        vim.env.VIMRUNTIME,
                      }
                    }
                  }
                }
          })


          end
          },
        })
      end
    }
  }
