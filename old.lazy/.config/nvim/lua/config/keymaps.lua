-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

-- map("n", "<Leader>v", ":cd ~/dotter<CR>:Telescope find_files<CR>", {})
-- map("n", "<C-p>", "<cmd>Telescope find_files<CR>", {
--   desc = "Ctrl+P to find files",
-- })

-- Use https://github.com/princejoogie/dir-telescope.nvim for dir specific search
-- map("n", "<C-s>", "<cmd>Telescope dir live_grep<CR>", {
--   desc = "Search inside specific dir",
-- })
-- map("n", "<C-f>", "<cmd>Telescope dir find_files<CR>", {
--   desc = "Find file in specific dir",
-- })

map("v", "<", "<gv")
map("v", ">", ">gv")

-- vim.api.nvim_create_user_command("LoadSnips", function()
--   require("luasnip.loaders.from_lua").load({
--     path = { "~/dotter/snippets" },
--   })
-- end, {})

-- https://www.reddit.com/r/neovim/comments/14v8vlh/comment/jrdxjf3/
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

-- Center on page up/down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- move current line / block with Alt-j/k similar to vscode.
map("n", "<A-j>", ":m .+1<cr>==")
map("n", "<A-k>", ":m .-2<cr>==")
