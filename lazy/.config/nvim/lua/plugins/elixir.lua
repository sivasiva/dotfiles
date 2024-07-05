local config = {
  {
    "lukas-reineke/lsp-format.nvim",
  },
  {
    "laytan/tailwind-sorter.nvim",
    requires = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)
      end

      --       vim.cmd([[
      --   au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
      --   au BufWritePost *.ex,*.eex,*.exs,*.heex lua vim.lsp.buf.format()
      -- ]])

      -- Tailwind
      require("lspconfig").tailwindcss.setup({
        init_options = {
          userLanguages = {
            elixir = "phoenix-heex",
            heex = "phoenix-heex",
            surface = "phoenix-heex",
          },
        },
        settings = {
          includeLanguages = {
            ["html-eex"] = "html",
            ["phoenix-heex"] = "html",
            heex = "html",
            eelixir = "html",
            elixir = "html",
            surface = "html",
          },
        },
      })

      require("tailwind-sorter").setup({
        on_save_enabled = false,
        on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.ex", "*.eex", "*.exs", "*.heex" },
        node_path = "node",
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          local map_opts = { buffer = true, noremap = true }
          vim.keymap.set("n", "<space>tw", ":TailwindSortOnSaveToggle<cr>", map_opts)
        end,
      })

      -- Emmet
      -- local lspconfig = require("lspconfig")
      -- local configs = require("lspconfig/configs")
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- lspconfig.emmet_ls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   filetypes = {
      --     "css",
      --     "eruby",
      --     "html",
      --     "javascript",
      --     "javascriptreact",
      --     "less",
      --     "sass",
      --     "scss",
      --     "svelte",
      --     "pug",
      --     "typescriptreact",
      --     "vue",
      --     "elixir",
      --   },
      --   init_options = {
      --     html = {
      --       options = {
      --         ["bem.enabled"] = true,
      --       },
      --     },
      --   },
      -- })
    end,
  },
}

return {}
