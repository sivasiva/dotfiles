return {
  {
    "m4xshen/autoclose.nvim",
    opts = {
      options = {
        disabled_filetypes = { "text" },
        disable_when_touch = true,
        pair_spaces = true,
      },
      keys = {
        ["'"] = {
          escape = true,
          close = true,
          pair = "''",
          disabled_filetypes = { "markdown" },
        },
        ["`"] = { escape = false, close = true, pair = "``" },
        [">"] = { escape = false, close = false, pair = "><" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      aliases = {
        elixir = "html",
        heex = "html",
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    theme = "catppuccin",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_dirname = false,
      show_basename = false,
    },
  },
  {
    "yamatsum/nvim-cursorline",
    opts = {
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
      cursorline = {
        enable = false,
      },
    },
  },
}
