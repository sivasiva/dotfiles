return {
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			local wk = require("which-key")
			wk.register({
				-- ----------------------------------------------
				-- p :: Projects
				-- ----------------------------------------------
				["<leader>p"] = {
					l = { "<cmd>Telescope neovim-project discover<cr>", "Find project" },
					f = { "<cmd>Telescope neovim-project discover<cr>", "Find project" },
					h = { "<cmd>Telescope neovim-project history<cr>", "Project History" },
					r = { "<cmd>NeovimProjectLoadRecent<cr>", "Open recent project" },
				},
				-- ----------------------------------------------
				-- s :: Telescope
				-- ----------------------------------------------
				-- ----------------------------------------------
				-- t :: Test
				-- ----------------------------------------------
				["<leader>t"] = {},
				-- ----------------------------------------------
				-- z :: FZF
				-- ----------------------------------------------
				["<leader>z"] = {
					a = { "<cmd>lua require('fzf-lua').autocmds()<CR>", "FZF autocmds" },
					b = { "<cmd>lua require('fzf-lua').buffers()<CR>", "FZF buffers" },
					c = { "<cmd>lua require('fzf-lua').commands()<CR>", "FZF commands" },
					f = { "<cmd>lua require('fzf-lua').files()<CR>", "FZF files" },
					g = { "<cmd>lua require('fzf-lua').live_grep()<CR>", "FZF live grep" },
					h = { "<cmd>lua require('fzf-lua').helptags()<CR>", "FZF helptags" },
					k = { "<cmd>lua require('fzf-lua').key_maps()<CR>", "FZF key maps" },
					r = { "<cmd>lua require('fzf-lua').oldfiles()<CR>", "FZF recent files" },
				},
			})
		end,
	},
}
