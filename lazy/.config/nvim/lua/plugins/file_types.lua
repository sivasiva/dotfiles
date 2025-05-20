return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _)
      -- https://www.reddit.com/r/neovim/comments/1h2k750/comment/lzkcd2p/
      -- https://neovim.io/doc/user/lua.html#vim.filetype.add%28%29
      vim.filetype.add({
        extension = {},
        filename = {
          ["config.yml.j2"] = "yaml",
          ["compose.yml.j2"] = "yaml",
        },
        pattern = {
          ["*.yml.j2"] = "yaml",
        },
      })
      vim.treesitter.language.register("docker", { "*compose*", "compose.yml.j2", "config.yml.j2", "*.yml.j2" })
      -- vim.treesitter.language.register("yaml", { "config.yml.j2" })
      -- vim.filetype.add({
      --   extension = { "*compose*" = "docker" },
      -- })
    end,
  },
  -- https://github.com/LazyVim/LazyVim/discussions/2841#discussioncomment-8927160
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {
          filetypes = { "jinja", "html", "yaml", "dockerfile" },
        },
      },
    },
  },
}
