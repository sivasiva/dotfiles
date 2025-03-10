return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _)
      vim.treesitter.language.register("docker", { "*compose*" })
      -- vim.filetype.add({
      --   extension = { "*compose*" = "docker" },
      -- })
    end,
  },
}
