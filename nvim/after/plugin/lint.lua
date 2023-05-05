-- https://github.com/mfussenegger/nvim-lint
local ok, lint = pcall(require, "lint")
if not ok then
  return
end

local efm = '%f:%l:%t: %m'

-- path/to/file:line:col: [severity] message (code)
-- local pattern = '[^:]+:(%d+):(%w+):(.+)'
-- local groups = { 'file', 'lnum', 'severity', 'message' }
local severity_map = {
  ['E'] = vim.diagnostic.severity.ERROR,
  ['W'] = vim.diagnostic.severity.WARN,
  ['I'] = vim.diagnostic.severity.INFO
}
--[[ local defaults = {["source"] = "xqCompile"} ]]

require('lint').xqCompile = {
  cmd = 'bin/compile',
  stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
  args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
  stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
  ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
  env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
  parser = require('lint.parser').from_errorformat(efm, {
        source = 'xqCompile',
        severity = severity_map,
    })}
-- require('lint.parser').from_pattern(pattern, groups, severity_map, defaults)

--lint.linters_by_ft({})
lint.linters_by_ft = {
  xquery = {'xqCompile'}
}


