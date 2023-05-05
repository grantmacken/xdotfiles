if vim.version().major == 0 and vim.version().minor < 7 then
  --vim.notify('The XQuery language server requires nvim >= 0.7', vim.log.levels.ERROR)
  return
end
local util = require 'lspconfig.util'

return {
  default_config = {
    cmd = { 'xquery-language-server' },
    filetypes = { 'xquery' },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
  },
  docs = {
    description = [[
https://github.com/grantmacken/xquery-language-server/
`xquery-language-server` can be installed via `npm`:
```sh
npm install -g xquery-language-server
```
]],
    default_config = {
      root_dir = [[util.find_git_ancestor]],
    },
  },
}
