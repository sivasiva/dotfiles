-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map("n", "<Leader>v", ":cd ~/.config/nvim/<CR>:Telescope find_files<CR>", {})
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", {})

map("v", "<", "<gv")
map("v", ">", ">gv")

vim.keymap.set("n", "<leader>Z", "<cmd>Zi<CR>", { desc = "Open Zoxide" })

vim.api.nvim_create_user_command("LoadSnips", function()
  require("luasnip.loaders.from_lua").load({
    path = { "~/snippets" },
  })
end, {})
