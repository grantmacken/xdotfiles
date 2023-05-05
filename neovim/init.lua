local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct'
vim.g.maplocalleader = " "
require("lazy").setup('plugins')

-- local function get_session_name()
--   local name = vim.fn.getcwd()
--   local branch = vim.fn.system("git branch --show-current")
--   if vim.v.shell_error == 0 then
--     return name .. branch
--   else
--     return name
--   end
-- end
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Only load the session if nvim was started with no args
--     if vim.fn.argc(-1) == 0 then
--       resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(get_session_name(), { dir = "dirsession", notify = false })
  end,
})
