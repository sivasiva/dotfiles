-- https://github.com/LazyVim/LazyVim/discussions/2896
-- Need the signs=false to fix startup errors
return {{
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            virtual_text = false,
            signs = false
        }
    }
}}
