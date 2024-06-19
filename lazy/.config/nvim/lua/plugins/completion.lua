-- REF: https://github.com/m4xshen/dotfiles/tree/main/nvim/nvim
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
    },
    config = function()
      local ls = require("luasnip")
      local lsTypes = require("luasnip.util.types")

      -- REF: https://www.reddit.com/r/neovim/comments/17o87nu/comment/k7wo306/
      -- ls.config.setup({
      --   history = true,
      --   update_events = { "TextChanged", "TextChangedI" },
      --   enable_autosnippets = true,
      --   ext_opts = {
      --     [lsTypes.choiceNode] = {
      --       active = {
      --         virt_text = { { "●", "PortalOrange" } },
      --         hl_mode = "combine",
      --       },
      --     },
      --     [lsTypes.insertNode] = {
      --       active = {
      --         virt_text = { { "●", "PortalBlue" } },
      --         hl_mode = "combine",
      --       },
      --     },
      --   },
      -- })

      -- REF: https://www.reddit.com/r/neovim/comments/tbtiy9/comment/i0bje36/
      -- vim.keymap.set({ "i", "s" }, "<C-l>", function()
      --   if ls.choice_active() then
      --     ls.change_choice(1)
      --   else
      --     ls.jump(1)
      --   end
      -- end)
      -- vim.keymap.set({ "i", "s" }, "<C-h>", function()
      --   if ls.choice_active() then
      --     ls.change_choice(-1)
      --   else
      --     ls.jump(-1)
      --   end
      -- end)

      vim.keymap.set({ "i", "s" }, "<C-L>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        ls.jump(-1)
      end, { silent = true })

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

        -- SuperTab like mapping for LuaSnip + nvim-cmp
        -- REF: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     if ls.expandable() then
        --       ls.expand()
        --     else
        --       cmp.confirm({
        --         select = true,
        --       })
        --     end
        --   else
        --     fallback()
        --   end
        -- end),
        --
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   elseif ls.locally_jumpable(1) then
        --     ls.jump(1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        --
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif ls.locally_jumpable(-1) then
        --     ls.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "buffer" },
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
        -- formatting = {
        --   format = function(_, item)
        --     local icons = require("lazyvim.config").icons.kinds
        --     if icons[item.kind] then
        --       item.kind = icons[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
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

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}
