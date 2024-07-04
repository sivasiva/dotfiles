return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- IMPORTANT !!! luasnip does not like symlinks.
      -- So dont `stow` snippets, just directly link to the dotter path, as here
      require("luasnip.loaders.from_lua").load({
        paths = { "~/dotter/snippets/" },
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
