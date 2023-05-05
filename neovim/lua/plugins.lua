return {
	-- https://github.com/catppuccin/nvim
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, config = function() vim.cmd([[colorscheme catppuccin-frappe]]) end, },
	{"nvim-lua/plenary.nvim"},
	{"stevearc/resession.nvim", enabled = true, opts = {}, },
        { "folke/which-key.nvim", lazy = true },
	  {
	    "numToStr/Comment.nvim",
	    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
	    opts = function()
	      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
	      return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
	    end,
	  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    config = {
	  size = function(term)
	    if term.direction == "horizontal" then
	      return 10
	    elseif term.direction == "vertical" then
	      return vim.o.columns * 0.4
	    end
	  end,
	open_mapping = [[<F6>]],
	shading_factor = 2,
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
    },
  },
	
}
