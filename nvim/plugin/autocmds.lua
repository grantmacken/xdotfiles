

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup("term_opened"),
  callback = function()
    local opt = { noremap = true }
    local bkm = vim.api.nvim_buf_set_keymap
    bkm(0, 't', '<esc>', [[<C-\><C-n>]], opt)
    bkm(0, 't', 'jk', [[<C-\><C-n>]], opt)
    bkm(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opt)
    bkm(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opt)
    bkm(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opt)
    bkm(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opt)
    vim.api.nvim_win_set_option(0, 'number', false)
    vim.api.nvim_win_set_option(0, 'relativenumber', false)
    vim.api.nvim_win_set_option(0, 'signcolumn', 'no')
  end,
})


-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})


-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
