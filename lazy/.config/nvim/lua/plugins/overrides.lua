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
              "*mise*",
              -- ".mise.toml",
              ".github",
              "*config*",
              "*env*",
              -- ".env.example",
              ".gitignore",
              "*tmuxp*",
              -- ".tmuxp.yml",
              -- ".tmux.conf",
              ".zshrc",
              "*local*",
              "deps",
              ".formatter.exs",
              -- `git-crypt`ed files
              ".vault*",
              ".gitattributes",
              "tmp",
              ".keep",
              ".github",
              "_build",
              ".iex.exs",
              "*tmux*",
              "*markdown*", -- Markdown Lint config like ~/.mdlrc
              "*yarnrc*",
              "*prettier*",
              ".babelrc",
              "webapp",
              "rx",
              "assets",
              "dist",
              "build",
              ".temp",
              ".rgignore",
              ".ripgreprc",
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
