-- REF: https://github.com/blakedietz/dotfiles-nvim/blob/423dc6ceb9349c6e7e872e2847306740c883ba94/lua/plugins/lexical.lua
local user_home = os.getenv("HOME")
local root_dir = function(fname)
  local lspconfig = require("lspconfig")
  local root = lspconfig.util.root_pattern(".git")(fname) or user_home
  return root
end

local custom_attach = function()
  -- local buf_name = vim.fn.expand("%") (does not include directory, only filename)
  local buf_name = vim.api.nvim_buf_get_name(0)
  local root = root_dir(buf_name)
  print("lexical-lsp attached to buffer")
end

local lexical = {
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  cmd = { os.getenv("HOME") .. "/projects/lexical-lsp/_build/dev/package/lexical/bin/start_lexical.sh" },
  root_dir = root_dir,
}

local lexicalLSP = {
  {

    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lexical = {
          mason = false, -- do not set up with mason
          filetypes = lexical.filetypes,
          on_attach = custom_attach,
          autostart = true,
        },
      },
      setup = {
        lexical = function(_, _)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")
          -- need to add the key with `configs.lexical = ...`
          -- so that configs.__new_index() runs before the setup that happens
          -- aftewards inside lazyvim setup:
          configs.lexical = {
            default_config = {
              filetypes = lexical.filetypes,
              cmd = lexical.cmd,
              -- root_dir = lexical.root_dir,
              root_dir = lspconfig.util.root_pattern(".git", "mix.exs"),
              autostart = true,
            },
          }
          -- returns false to use the set-up from lazy.vim with lspconfig
          -- (adds capabilities key, executes lspconfig.lexical.setup(opts))
          return false
        end,
      },
    },
  },
}

local elixirToolsLSPConfig = {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = false },
        elixirls = {
          -- specify a repository and branch
          -- repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = false,
            fetchDeps = false,
            suggestSpecs = false,
          }),
          on_attach = function(_, _)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

return {}
