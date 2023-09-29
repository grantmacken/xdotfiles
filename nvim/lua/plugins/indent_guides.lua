return
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", 
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    },
  config = function(_, opts)
  require('ibl').setup(opts)
  end
}
