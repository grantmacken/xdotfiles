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

local unlistQuickfistBuffers = function()
  autocmd("FileType", {
    desc = "Unlist quickfist buffers",
    group = augroup("unlist_quickfist"),
    pattern = "qf",
    callback = function() vim.opt_local.buflisted = false end,
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

local onLeave = function()
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
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      log('Lang Server attached buffer: ' .. bufnr)
      log('Lang Server client ID: ' .. client.id)
      log('Lang Server name: ' .. client.name)
      --  :lua =vim.lsp.get_clients()[1].server_capabilities
      local capabilities = client.server_capabilities
      -- for key, _ in pairs(capabilities) do
      --   log(key)
      -- end
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      -- SYMBOLS
      -- symbol under cursor
      if capabilities.hoverProvider then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      end
      -- DEFINITIONS && DECLARATIONS
      if capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      end
      if capabilities.typeDefinitionProvider then
        vim.keymap.set("n", "go", vim.lsp.buf.definition, bufopts)
      end

      if capabilities.declarationProvider then
        vim.keymap.set("n", "gD", vim.lsp.buf.definition, bufopts)
      end

      if capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end

      if capabilities.renameProvider then
        vim.keymap.set({ "n" }, "<F2>", vim.lsp.buf.rename, bufopts)
      end
      -- format on save
      if capabilities.documentFormattingProvider then
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
        --   buffer = bufnr,
        --   callback = function()
        --     vim.lsp.buf.format({ async = true })
        --   end
        -- })
        vim.keymap.set("n", "<F3>", vim.lsp.buf.format, bufopts)
      end

      if capabilities.codeActionProvider then
        vim.keymap.set({ "n" }, "<F4>", vim.lsp.buf.code_action, bufopts)
      end

      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<leader>fd', telescope.lsp_document_symbols, bufopts)
      vim.keymap.set('n', '<leader>fq', telescope.lsp_workspace_symbols, bufopts)

      --  if capabilities.documentHighlightProvider then
      -- TODO!
      --   autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      -- autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      --
      -- end
      -- if client.server_capabilities.diagnosticProvider then
      --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      -- end

      --TODO  set on capabilities
      -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      -- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      -- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      -- vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
      -- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
      -- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    end,
  })
end

local onDiagnosticChange = function()
  autocmd("DiagnosticChanged", {
    desc = "My Diagnostic Changed",
    group = augroup("diagnostic_changed"),
    callback = function(args)
      vim.diagnostic.setloclist({ open = false })
    end,
  })
end



M.setup = function()
  checkTime()
  highlightYank()
  closeWithQ()
  wrapWithSpell()
  unlistQuickfistBuffers()
  onOpenGoToLastBuff()
  onLeave()
  onLangServerAttach()
  onDiagnosticChange()
  log('autocommands setup completed')
end

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
-- https://neovim.io/doc/user/lsp.html
-- When the LSP client starts it
-- enables diagnostic https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
-- 'omnifunc' is set
-- 'tagfunc' is set
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
--

return M
