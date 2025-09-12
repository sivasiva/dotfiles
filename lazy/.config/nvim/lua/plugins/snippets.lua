-- FROM: https://github.com/xzbdmw/nvimconfig/blob/b123d3338d02ed56ea90555f308eaa90f6e3adf6/lua/plugins/mini-snippets.lua

return {
  {
    "echasnovski/mini.snippets",
    opts = function()
      local make_stop = function()
        local au_opts = { pattern = "*:n", once = true }
        au_opts.callback = function()
          while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
          end
        end
        vim.api.nvim_create_autocmd("ModeChanged", au_opts)
      end
      local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
      vim.api.nvim_create_autocmd("User", opts)
    end,
  },
}
