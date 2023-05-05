local ok, formatter = pcall(require, 'formatter')
if not ok then
  return
end
local util = require 'formatter.util'

formatter.setup {
  filetype = {
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
    json = {
      require('formatter.filetypes.json').jq,
    },
    yaml = {
      require('formatter.filetypes.yaml').prettierd,
    },
    html = {
      require('formatter.filetypes.html').tidy,
    },
    css = {
      require('formatter.filetypes.css').prettierd,
    },
    javascript = {
      require('formatter.filetypes.javascript').prettierd,
    },
  },
}
