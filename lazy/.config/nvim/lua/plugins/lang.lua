return {

  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  {
    "NoahTheDuke/vim-just",
  },
  -- {
  --   "HiPhish/jinja.vim",
  -- },
  -- {
  --   -- Highlight, edit, and navigate code
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     "vrischmann/tree-sitter-templ",
  --   },
  --   build = ":TSUpdate",
  --   opts = function()
  --     -- code
  --     vim.filetype.add({ extension = { templ = "templ" } })
  --
  --     local templ_format = function()
  --       local bufnr = vim.api.nvim_get_current_buf()
  --       local filename = vim.api.nvim_buf_get_name(bufnr)
  --       local cmd = "templ fmt " .. vim.fn.shellescape(filename)
  --
  --       vim.fn.jobstart(cmd, {
  --         on_exit = function()
  --           -- Reload the buffer only if it's still the current buffer
  --           if vim.api.nvim_get_current_buf() == bufnr then
  --             vim.cmd("e!")
  --           end
  --         end,
  --       })
  --     end
  --
  --     local on_attach = function(client, bufnr)
  --       local opts = { buffer = bufnr, remap = false }
  --
  --       vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  --       vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  --       vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  --       vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  --       vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  --       vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  --       vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  --       vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  --       vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  --       vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  --
  --       -- vim.keymap.set("n", "<leader>lf", custom_format, opts)
  --       -- vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
  --       vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = templ_format })
  --     end
  --
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --     local lspconfig = require("lspconfig")
  --
  --     lspconfig.templ.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --     })
  --
  --     lspconfig.tailwindcss.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --       filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
  --       init_options = { userLanguages = { templ = "html" } },
  --       root_dir = lspconfig.util.root_pattern(
  --         "tailwind.config.js",
  --         "tailwind.config.ts",
  --         "postcss.config.js",
  --         "postcss.config.ts",
  --         "package.json",
  --         "node_modules",
  --         ".git",
  --         "mix.exs",
  --         "go.work",
  --         "go.mod"
  --       ),
  --     })
  --
  --     lspconfig.html.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --       filetypes = { "html", "templ" },
  --     })
  --
  --     lspconfig.htmx.setup({
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --       filetypes = { "html", "templ" },
  --     })
  --
  --     local cmp = require("cmp")
  --     cmp.setup({
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = true }),
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --       }),
  --     })
  --
  --     require("nvim-treesitter.configs").setup({
  --       ensure_installed = { "templ" },
  --       sync_install = false,
  --       auto_install = true,
  --       ignore_install = { "javascript" },
  --       highlight = {
  --         enable = true,
  --       },
  --     })
  --   end,
  -- },
}
