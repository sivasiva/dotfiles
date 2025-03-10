-- REF: https://github.com/m4xshen/dotfiles/tree/main/nvim/nvim
-- REF: https://github.com/xero/dotfiles/blob/2399d76adbc2a224a305b02d938deabc4cee3df1/neovim/.config/nvim/lua/plugins/cmp.lua

local config = {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = function()
      local cmp = require("cmp")

      vim.filetype.add({ extension = { templ = "templ" } })

      -- -------------------------------------------------
      -- templ / htmx
      -- -------------------------------------------------
      local lspconfig = require("lspconfig")

      local custom_format = function()
        if vim.bo.filetype == "templ" then
          local bufnr = vim.api.nvim_get_current_buf()
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local cmd = "templ fmt " .. vim.fn.shellescape(filename)

          vim.fn.jobstart(cmd, {
            on_exit = function()
              -- Reload the buffer only if it's still the current buffer
              if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd("e!")
              end
            end,
          })
        else
          vim.lsp.buf.format()
        end
      end

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        -- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        -- vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        -- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        -- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        -- vim.keymap.set("n", "<leader>lf", custom_format, opts)
        -- vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
        vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = custom_format })
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches

      -- local lsp_servers = { "gopls", "ccls", "cmake", "tsserver", "templ" }
      --
      -- for _, lsp in ipairs(lsp_servers) do
      --   lspconfig[lsp].setup({
      --     on_attach = lsp_attach,
      --     -- capabilities = capabilities,
      --     capabilities = lsp_capabilities,
      --   })
      -- end

      lspconfig.templ.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
        root_dir = lspconfig.util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git",
          "mix.exs",
          "go.work",
          "go.mod"
        ),
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
            experimental = {
              classRegex = {
                'class[:]\\s*"([^"]*)"',
              },
            },
          },
        },
      })

      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })

      lspconfig.htmx.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })

      local configs = require("lspconfig.configs")
      configs.templ = {
        default_config = {
          cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/Users/siva2025/templ.log" },
          filetypes = { "templ" },
          root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
          settings = {},
        },
      }
      -- local ls = require("luasnip")
      -- -- local lsTypes = require("luasnip.util.types")
      --
      -- vim.keymap.set({ "i", "s" }, "<C-L>", function()
      --   ls.jump(1)
      -- end, {
      --   silent = true,
      -- })
      -- vim.keymap.set({ "i", "s" }, "<C-J>", function()
      --   ls.jump(-1)
      -- end, {
      --   silent = true,
      -- })
      --
      -- local nvim_lsp = require("lspconfig")
      -- local lspkind = require("lspkind")
      -- cmp.setup({
      --   snippet = {
      --     expand = function(args)
      --       ls.lsp_expand(args.body) -- For `luasnip` users.
      --       -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      --     end,
      --   },
      --   window = {
      --     completion = cmp.config.window.bordered(),
      --     documentation = cmp.config.window.bordered(),
      --   },
      --
      --   mapping = cmp.mapping.preset.insert({
      --     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --     ["<CR>"] = cmp.mapping.confirm({
      --       select = true,
      --     }),
      --     ["<Tab>"] = cmp.mapping.select_next_item(),
      --     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      --   }),
      --   sources = cmp.config.sources({
      --     {
      --       name = "nvim_lsp",
      --     },
      --     {
      --       name = "luasnip",
      --     },
      --     {
      --       name = "nvim_lua",
      --     },
      --     {
      --       name = "buffer",
      --     },
      --   }),
      --   enabled = function()
      --     -- disable completion in comments
      --     local context = require("cmp.config.context")
      --
      --     if vim.bo.filetype == "neo-tree" then
      --       print("INSIDE Neotree", vim.bo.filetype)
      --       return false
      --     end
      --
      --     -- keep command mode completion enabled
      --     if vim.api.nvim_get_mode().mode == "c" then
      --       return true
      --     else
      --       return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      --     end
      --   end,
      --
      --   formatting = {
      --     expandable_indicator = true,
      --     fields = { "abbr", "kind", "menu" },
      --     format = lspkind.cmp_format({
      --       mode = "symbol_text",
      --       maxwidth = 50,
      --       ellipsis_char = "...",
      --       menu = {
      --         buffer = "[Buffer]",
      --         nvim_lsp = "[LSP]",
      --         nvim_lua = "[Lua]",
      --         luasnip = "[LuaSnip]",
      --         latex_symbols = "[Latex]",
      --       },
      --       before = function(entry, vim_item)
      --         local icons = require("lazyvim.config").icons.kinds
      --         if icons[vim_item.kind] then
      --           vim_item.kind = icons[vim_item.kind] .. vim_item.kind
      --         end
      --
      --         vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
      --         return vim_item
      --       end,
      --     }),
      --   },
      -- })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { {
          name = "buffer",
        } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = "path",
          },
        }, {
          {
            name = "cmdline",
          },
        }),
      })

      cmp.setup.filetype({ "sql" }, {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      })
    end,
  },
}

return config
