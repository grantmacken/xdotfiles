local log = require('my.util').log
log('filetype: golang')

-- workspace_folders = nil,
-- before_init(initialize_params, config)
-- on_init(client, initialize_result)
-- on_exit(code, signal, client_id)
-- on_attach (client, bufnr )
-- handlers = {}
-- get_language_id
-- offset_encoding
-- on_error

local root_dir = vim.fs.dirname(vim.fs.find({ 'Makefile', '.git' }, { upward = true })[1])
local onInit = function(client, _)
  log('client' .. client)
end
vim.lsp.start({
  name = 'gopls',
  cmd = { 'gopls' },
  root_dir = root_dir,
  on_init = onInit,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
