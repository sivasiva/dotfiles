return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      -- https://stackoverflow.com/a/69923907/359505
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".DS_Store",
            "vendor",
            "go.mod",
            "go.sum",
            "db/seeds",
            "testhelpers",
            -- "api/*",
          },
        },
      })
    end,
  },
  {
    "princejoogie/dir-telescope.nvim",
  },
}
