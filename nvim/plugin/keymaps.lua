-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
vim.cmd [[ command! W  execute ':w' ]] -- map :W to :w (helps which-key issue)
local opts = { noremap = true, silent = true }
local km = vim.keymap.set
km('', 'Q', '<Nop>', { silent = true }) -- Get rid of annoying ex keybind
km('n', '-', '<cmd>NeoTreeFloatToggle filesystem<cr>', opts)
km('n', '<A-b>', '<cmd>NeoTreeFloatToggle buffers<cr>', opts)
-- Diagnostics and Quickfix
km('n', '<A-q>', require('my.buffers').quickfix_toggle, { noremap = true })
-- better up/down
km("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
km("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- better indenting
km("v", "<", "<gv")
km("v", ">", ">gv")
-- Move to window using the <ctrl> hjkl keys
km("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
km("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
km("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
km("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- Resize window using <ctrl> arrow keys
km("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
km("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
km("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
km("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- Move Lines
km("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
km("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
km("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
km("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
km("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
km("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
km({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
km({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
km("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
km("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
km("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
km("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
km("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
km("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- save file
km({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
km("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- new file
km("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

km("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
km("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
km('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', {desc = "diagnostic setqflist"})
-- Quickfix history navigation
--[[ km('', ']h', '<Cmd>cnewer<CR>', opts) ]]
--[[ km('', '[h', '<Cmd>colder<CR>', opts) ]]
-- km('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {desc = "previous diagnostic" })
-- km('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {desc = "next diagnostic" })

-- windows
km("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
km("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
km("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
km("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
km("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
km("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
-- tabs
km("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
km("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
km("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
km("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
km("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
km("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- harpoon
-- km('n', '<leader>m', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = "Harpoon Quick Menu" })  

--km('n', '_', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
--km('n', 'gd', '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>', opts)
--km('n', '<F5>', '<cmd>ToggleTermSendCurrentLine<cr>', opts)
--Add leader shortcuts
--km('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],opts)
--km('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
--km('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
--km('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
--km('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
--km('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
--km('' '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
--km('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
--km('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
--
local neoTreeCmd_ok, neoTreeCmd = pcall(require, 'neo-tree.command')
if neoTreeCmd_ok then
  km('', '<A-d>', function()
    neoTreeCmd.execute {
      source = 'diagnostics',
      reveal = true,
      position = 'bottom',
      toggle = true,
    }
  end, { noremap = true })
  km('n', '-', function()
    neoTreeCmd.execute {
      source = 'filesystem',
      reveal = true,
      position = 'float',
      toggle = true,
    }
  end, { noremap = true })
  km('n', '<A-b>', function()
    neoTreeCmd.execute {
      source = 'buffers',
      reveal = true,
      position = 'right',
      toggle = true,
    }
  end, { noremap = true })
  km('n', '<A-g>', function()
    neoTreeCmd.execute {
      source = 'git_status',
      reveal = true,
      position = 'float',
      toggle = true,
    }
  end, { noremap = true })
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if luasnip_ok then
  km('i','<tab>',function() return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,{ expr = true, silent = true})
  km('s','<tab>', function() luasnip.jump(1) end, opts )
  km('i','<s-tab>', function() luasnip.jump(-1) end,opts )
  km('s','<s-tab>', function() luasnip.jump(-1) end,opts )
end

--local cmp_ok, cmp = pcall(require, "cmp")
--if cmp_ok then

--end
