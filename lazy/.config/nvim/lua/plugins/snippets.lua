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
    "saghen/blink.cmp",
    version = "*",
    -- !Important! Make sure you're using the latest release of LuaSnip
    -- `main` does not work at the moment
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
      snippets = { preset = "luasnip" },
      -- ensure you have the `snippets` source (enabled by default)
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
