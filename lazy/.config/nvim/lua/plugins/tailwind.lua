-- vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
-- require("vim.lsp.log").set_format_func(vim.inspect)
-- vim.lsp.set_log_level("trace")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          },
        },
      },
    },
  },
}
