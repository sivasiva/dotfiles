-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.background = "dark"
vim.opt.relativenumber = false

vim.g.lazyvim_mini_snippets_in_completion = true

-- https://github.com/folke/snacks.nvim/discussions/1735
-- https://www.reddit.com/r/neovim/comments/1ajpdrx/comment/kpnjf9l/
vim.g.root_spec = { "cwd" }
