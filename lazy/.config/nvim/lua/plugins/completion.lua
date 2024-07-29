-- REF: https://github.com/m4xshen/dotfiles/tree/main/nvim/nvim
-- REF: https://github.com/xero/dotfiles/blob/2399d76adbc2a224a305b02d938deabc4cee3df1/neovim/.config/nvim/lua/plugins/cmp.lua
return {
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
    config = function()
      local ls = require("luasnip")
      -- local lsTypes = require("luasnip.util.types")

      vim.keymap.set({ "i", "s" }, "<C-L>", function()
        ls.jump(1)
      end, {
        silent = true,
      })
      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        ls.jump(-1)
      end, {
        silent = true,
      })

      local nvim_lsp = require("lspconfig")
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            ls.lsp_expand(args.body) -- For `luasnip` users.
            -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
          }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
          },
          {
            name = "luasnip",
          },
          {
            name = "nvim_lua",
          },
          {
            name = "buffer",
          },
        }),
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")

          -- keep command mode completion enabled
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,

        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[LuaSnip]",
              latex_symbols = "[Latex]",
            },
            before = function(entry, vim_item)
              local icons = require("lazyvim.config").icons.kinds
              if icons[vim_item.kind] then
                vim_item.kind = icons[vim_item.kind] .. vim_item.kind
              end

              vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
              return vim_item
            end,
          }),
        },
      })

      -- nvim_lsp.tailwindcss.setup({
      --   settings = {
      --     tailwindCSS = {
      --       includeLanguages = {
      --         elixir = "html-eex",
      --         eelixir = "html-eex",
      --         heex = "html-eex",
      --       },
      --     },
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
    end,
  },
}
