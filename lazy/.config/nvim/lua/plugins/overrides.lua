return {
  {
    "folke/snacks.nvim",
    opts = {
      -- exclude = {
      --   ".git",
      --   "node_modules",
      --   ".yarn/cache",
      --   ".DS_Store",
      -- },
      -- explorer = {
      --   -- your explorer configuration comes here
      --   -- or leave it empty to use the default settings
      --   -- refer to the configuration section below
      -- },
      picker = {
        sources = {
          explorer = {
            include = {
              ".mise",
              ".github",
              ".config",
            },
            exclude = {
              ".idea",
              ".git",
            },
            -- hidden = true, -- enable showing hidden files
            -- your explorer picker configuration comes here
            -- or leave it empty to use the default settings
          },
        },
      },
    },
  },
}
