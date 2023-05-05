local lsp_ok, lsp = pcall(require, "lsp-zero")
if not lsp_ok then return end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

local mason_ok, mason = pcall(require, "mason")
if mason_ok then
 mason.setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      }},
    ensure_installed = {
      "stylua",
      "shfmt",
      "yamllint",
      "yamlfmt",
      "prettierd",
    }})
else
  return
end

lsp.preset({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
lspconfig['lua_ls'].setup(lsp.nvim_lua_ls())
lsp.setup()

local null_ls_ok,null_ls = pcall(require, "null-ls")
if not null_ls_ok then return end
null_ls.setup({
  on_attach = function(client, bufnr)
    local format_cmd = function(input)
      vim.lsp.buf.format({
        id = client.id,
        timeout_ms = 5000,
        async = input.bang,
      })
    end
    local bufcmd = vim.api.nvim_buf_create_user_command
    bufcmd(bufnr, 'NullFormat', format_cmd, {
      bang = true,
      range = true,
      desc = 'Format using null-ls'
    })
    vim.keymap.set('n', 'gq', '<cmd>NullFormat!<cr>', {buffer = bufnr})
  end,
  sources = {
    -- Replace these with the tools you have installed
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.yamfmt,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.yamllint,
  }
})
--[[ lspConfig['lua_ls'].setup({  ]]
--[[     capabilities = capabilities, ]]
--[[     on_attach = onAttach, ]]
--[[     settings = { ]]
--[[       Lua = { ]]
--[[       runtime = {version = 'LuaJIT'}, ]]
--[[       workspace = { ]]
--[[         library = vim.api.nvim_get_runtime_file("", true), ]]
--[[         checkThirdParty = false }, ]]
--[[      : telemetry = { enable = false}, ]]
--[[       diagnostics = { globals = { 'vim' }}, ]]
--[[       completion = {callSnippet = "Replace"} ]]
--[[       }}}) ]]



--[[ local cmpNvimLsp_ok, cmpNvimLsp = pcall(require, "cmp_nvim_lsp") ]]
--[[ if not cmpNvimLsp_ok then return end ]]
--[[]]
--[[ local capabilities = cmpNvimLsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()) ]]
--[[ local onAttach  = function (client,bufnr) ]]
--[[ print('conected') ]]
--[[  local diagnostic_goto = function (next, severity) ]]
--[[   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev ]]
--[[   severity = severity and vim.diagnostic.severity[severity] or nil ]]
--[[   return function() ]]
--[[     go({ severity = severity }) ]]
--[[   end ]]
--[[ end ]]
--[[]]
--[[]]
--[[ local km = vim.keymap.set ]]
--[[ --km( "n","<leader>cd", vim.diagnostic.open_float,{buffer = bufnr, remap = false, desc = "Line Diagnostics" }) ]]
--[[ km( "n","<leader>cl","<cmd>LspInfo<cr>",{buffer = bufnr, remap = false, desc = "LSP Info" }) ]]
--[[ --km( "n","<cmd>Telescope lsp_definitions<cr>",{buffer = bufnr, remap = false, desc = "Goto Definition" }) ]]
--[[ km( "n","gr","<cmd>Telescope  lsp_references<cr>",{buffer = bufnr, remap = false, desc = "References" }) ]]
--[[ km( "n","]d",diagnostic_goto(true),{buffer = bufnr, remap = false, desc = "Next Diagnostic" }) ]]
--[[ end ]]
--[[]]
--[[]]
--[[ local masonLspConfig_ok, masonLspConfig = pcall(require, "mason-lspconfig") ]]
--[[ if not masonLspConfig_ok then return end ]]

--[[  masonLspConfig.setup({ ensure_installed = { ]]
--[[   "awk_ls", ]]
--[[   "bashls", ]]
--[[   "cssls", ]]
--[[   "elixirls", ]]
--[[   "erlangls", ]]
--[[   "eslint", ]]
--[[   "grammarly", ]]
--[[   "html", ]]
--[[   "jsonls", ]]
--[[   "lemminx", ]]
--[[   "lua_ls", ]]
--[[   "rust_analyzer", ]]
--[[   "tsserver", ]]
--[[   "yamlls", ]]
--[[ }}) ]]



--[[]]
--[[]]
--[[  masonLspConfig.setup_handlers({ ]]
--[[   function (server_name) -- default handler (optional) ]]
--[[         require("lspconfig")[server_name].setup {} ]]
--[[     end, ]]
--[[   ['lua_ls'] = function() ]]
--[[     lspConfig['lua_ls'].setup({ ]]
--[[     capabilities = capabilities, ]]
--[[     on_attach = onAttach, ]]
--[[     settings = { ]]
--[[       Lua = { ]]
--[[       runtime = {version = 'LuaJIT'}, ]]
--[[       workspace = { ]]
--[[         library = vim.api.nvim_get_runtime_file("", true), ]]
--[[         checkThirdParty = false }, ]]
--[[       telemetry = { enable = false}, ]]
--[[       diagnostics = { globals = { 'vim' }}, ]]
--[[       completion = {callSnippet = "Replace"} ]]
--[[       }}}) ]]
--[[   end ]]
--[[ }) ]]

-- diagnostics
--[[ for name, icon in pairs(require("my.icons").diagnostics) do ]]
--[[   name = "DiagnosticSign" .. name ]]
--[[   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" }) ]]
--[[ end ]]
--[[]]
--[[ vim.diagnostic.config({ ]]
--[[   underline = true, ]]
--[[   update_in_insert = false, ]]
--[[   virtual_text = { spacing = 4, prefix = "●" }, ]]
--[[   severity_sort = true, ]]
--[[ }) ]]

