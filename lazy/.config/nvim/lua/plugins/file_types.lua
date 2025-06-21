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
  {
    "mason-org/mason.nvim",
    opts = function()
      local lspconfig = require("lspconfig")

      lspconfig.emmet_language_server.setup({
        filetypes = {
          "css",
          "eruby",
          "elixir",
          "html",
          "heex",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "pug",
          "typescriptreact",
        },
        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
        -- **Note:** only the options listed in the table are supported.
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = false,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })
    end,
  },
}
