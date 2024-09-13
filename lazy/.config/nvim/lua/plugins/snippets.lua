return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- -------------------------------------------------
      -- IMPORTANT !!! luasnip does not work with symlinks.
      -- So `stow snippets` wont work. Just directly link to the dotter path, as here
      -- -------------------------------------------------
      require("luasnip.loaders.from_lua").load({
        paths = { "~/.config/snippets/" },
      })
    end,
  },
  {
    "nvimdev/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup({
        temp_dir = "~/templates",
      })
    end,
  },
}
