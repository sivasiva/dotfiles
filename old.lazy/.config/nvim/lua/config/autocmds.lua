-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- -- Check if we need to reload the file when it changed
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = augroup("general"),
--   pattern = { "*.ex", "*.heex" },
--   callback = function()
--     -- autocmd BufRead,BufNewFile *.elixir setlocal filetype=html.elixir
--     if vim.o.buftype ~= "nofile" then
--       vim.cmd("checktime")
--     end
--   end,
-- })
local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local configure = function(details)
  print("FileType event", dump(details))
  vim.filetype.add({
    -- extension = {
    --   equivs = "debcontrol",
    --   jad = "java",
    --   rasi = "rasi",
    --   tfstate = "json",
    -- },
    -- filename = {
    --   [".ansible-lint"] = "yaml",
    --   [".dockerignore"] = "gitignore",
    --   [".gitlint"] = "cfg",
    --   [".sqlfluff"] = "cfg",
    --   ["control_template"] = "debcontrol",
    --   ["shellcheckrc"] = "conf",
    -- },
    pattern = {
      ["*ex"] = "eelixir",
      -- ["%.secrets.*"] = "sh",
      -- [".*%.gitignore.*"] = "gitignore",
      -- [".*%.properties.*"] = "jproperties",
      -- [".*/%.kaf/config"] = "yaml",
      -- [".*Dockerfile.*"] = "dockerfile",
      -- [".*Jenkinsfile.*"] = "groovy",
      -- [".*emails/cur/.*"] = "mail",
      -- [".*emails/new/.*"] = "mail",
      -- [".*emails/tmp/.*"] = "mail",
      -- [".*envrc.*"] = "sh",
      -- [".*mkd%.txt"] = "markdown",
      -- [".*my%-ublock.*"] = "json",
      -- ["muttrc%..*"] = "muttrc",
      --
      -- -- Similar logic to pearofducks/ansible-vim
      -- [".*group_vars/.*"] = "yaml.ansible",
      -- [".*host_vars/.*"] = "yaml.ansible",
      --
      -- [".*handlers/.*%.ya?ml"] = "yaml.ansible",
      -- [".*roles/.*%.ya?ml"] = "yaml.ansible",
      -- [".*tasks/.*%.ya?ml"] = "yaml.ansible",
      --
      -- [".*hosts.*.ya?ml"] = "yaml.ansible",
      -- [".*main.ya?ml"] = "yaml.ansible",
      -- [".*playbook.*.ya?ml"] = "yaml.ansible",
      -- [".*site.ya?ml"] = "yaml.ansible",
    },
  })
end

-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "VeryLazy",
--   group = vim.api.nvim_create_augroup("VeryLazy_filetypes", {}),
--   callback = configure,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
--   pattern = { "c", "rust", "lua", "sh", "python", "verilog", "elixir", "html", "html-heex", "phoenix-html" },
--   callback = function(details)
--     print("BufEnter event", dump(details))
--     -- vim.cmd.LspStart()
--     -- print("now") -- this just helps me know when the lsp starts
--   end,
-- })

-- autocmd! BufRead,BufNewFile *.html  call jinja#AdjustFiletype()

-- https://www.reddit.com/r/neovim/comments/whz2d7/setting_an_autocmd_pattern_for_similar_paths/
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ansible"),
  pattern = { "*.yml.j2" },
  callback = function()
    vim.opt.filetype = "yaml.ansible"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("docker"),
  pattern = { "*.dockerfile.*" },
  callback = function()
    vim.opt.filetype = "dockerfile"
  end,
})
