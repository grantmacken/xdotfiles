local M = {}
local log = require('my.util').log

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- Check if we need to reload the file when it changed
local checkTime = function()
  autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("check_time"),
    command = "checktime",
  })
end

local highlightYank = function()
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
end

local closeWithQ = function()
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
end

local wrapWithSpell = function()
  autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
end

local onOpenGoToLastBuff = function()
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
end

local onLeaveSetSession = function()
autocmd("VimLeavePre", {
  desc = "On leave save session",
  group = augroup("save_session"),
  callback = function()
    local resession_ok, resession = pcall(require, 'resession ')
    if resession_ok then
      local save = resession.save
      save('Last Session')
      save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
    end
  end,
})
end

local onLangServerAttach = function()
autocmd("LspAttach", {
  desc = "My LSP Attach",
  group = augroup("lsp_attach"),
  callback = function(args)
    local bufnr = args.buf
    local opts = {buffer = bufnr}
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    log(' on lang server attached')
    -- textDocument/completion
    if client.server_capabilities.completionProvider then
      -- TODO redundant below is default
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      -- TODO redundant below is default
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
    if client.server_capabilities.hoverProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end

    if client.server_capabilities.diagnosticProvider then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end

      --TODO  set on capabilities
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end,
})
end

M.setup = function()
  checkTime()
  highlightYank()
  closeWithQ()
  wrapWithSpell()
  onOpenGoToLastBuff()
  onLeaveSetSession()
  onLangServerAttach()
  log( 'autocommands setup completed' )
end

-- -- go to last loc when opening a buffer
-- autocmd("FileType", {
--   desc = "Unlist quickfist buffers",
--   group = augroup("unlist_quickfist"),
--   pattern = "qf",
--   callback = function() vim.opt_local.buflisted = false end,
-- })
--

--
-- autocmd("FileType", {
--   desc = "ocaml-lsp-server",
--   group = augroup("ocamllsp"),
--   pattern = {"ocaml"},
--   callback = function()
--     local language_id_of = {
--       menhir = 'ocaml.menhir',
--       ocaml = 'ocaml',
--       ocamlinterface = 'ocaml.interface',
--       ocamllex = 'ocaml.ocamllex',
--       reason = 'reason',
--       dune = 'dune',
--     }
--     local get_language_id = function(_, ftype)
--       return language_id_of[ftype]
--     end
--     local root_dir = vim.fs.dirname(vim.fs.find({'*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace'}, { upward = true })[1])
--     local client = vim.lsp.start({
--             name = 'ocamllsp',
--             cmd = { 'ocamllsp' },
--             filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
--             root_dir = root_dir,
--             get_language_id = get_language_id
--         })
--     vim.lsp.buf_attach_client(0, client)
--     vim.notify('ocamllsp attached' )
--   end,
-- })
--
-- autocmd("FileType", {
--   desc = "golang language server",
--   group = augroup("gopls"),
--   pattern = "go",
--   callback = function()
--     local root_dir = vim.fs.dirname(
--     vim.fs.find({ 'go.mod', 'go.work', '.git' }, { upward = true })[1]
--     )
--     local client = vim.lsp.start({
--             name = 'gopls',
--             cmd = { 'gopls' },
--             root_dir = root_dir,
--         })
--     vim.lsp.buf_attach_client(0, client)
--     vim.notify('gopls attached' )
--   end,
-- })
--
-- autocmd("FileType", {
--   desc = "lua language server",
--   group = augroup("lua_ls"),
--   pattern = "lua",
--   callback = function()
--     local runtime_path = vim.split(package.path, ";")
--     table.insert(runtime_path, "lua/?.lua")
--     table.insert(runtime_path, "lua/?/init.lua")
--     local root_dir = vim.fs.dirname(vim.fs.find({ 'Makefile', '.git', 'init.lua'  }, { upward = true })[1])
--     local client = vim.lsp.start({
--       name = 'lua_ls',
--       cmd = { 'lua-language-server' },
--       root_dir = root_dir,
--       -- workspace_folders = nil,
--       -- before_init(initialize_params, config) 
--       -- on_init(client, initialize_result)
--       on_init = function(_, _)
--         vim.notify( 'Init lua-language-server' )
--       end,
--       -- on_exit(code, signal, client_id)
--       -- on_attach (client, bufnr )
--       -- handlers = {}
--       -- get_language_id
--       -- offset_encoding
--       -- on_error
--       settings = {
--         Lua = {
--           runtime = {
--             version = "LuaJIT",
--             path = runtime_path,
--           },
--           diagnostics = { globals = { "vim" }},
--           --  workspace = {library = vim.api.nvim_get_runtime_file("", true)},
--           telemetry = {enable = false},
--         }}
--       })
--     vim.lsp.buf_attach_client(0, client)
--     vim.notify('lua language server attached' )
--   end,
-- })
 -- https://neovim.io/doc/user/lsp.html
-- When the LSP client starts it 
-- enables diagnostic https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
-- 'omnifunc' is set 
-- 'tagfunc' is set 
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it. 
--

return M
