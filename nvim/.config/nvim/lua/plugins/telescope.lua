return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<c-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		end,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
			-- vim.keymap.set("n", "<leader>f", "<cmd>FzfLua<CR>", { desc = "FzfLua", silent = true })

			-- stylua ignore
			vim.keymap.set("n", "<leader>zp", vim.cmd.FzfLua, { desc = "F[Z]F Command [P]alette", silent = true })
			vim.keymap.set(
				"n",
				"<leader>zf",
				"<cmd>lua require('fzf-lua').files()<CR>",
				{ desc = "[Z]earch [F]iles", silent = true }
			)
			vim.keymap.set(
				"n",
				"<c-P>",
				"<cmd>lua require('fzf-lua').files()<CR>",
				{ desc = "[Z]earch [F]iles", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zb",
				"<cmd>lua require('fzf-lua').buffers()<CR>",
				{ desc = "[Z]earch [B]uffers", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zh",
				"<cmd>lua require('fzf-lua').helptags()<CR>",
				{ desc = "[Z]earch [H]elp", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>z.",
				"<cmd>lua require('fzf-lua').oldfiles()<CR>",
				{ desc = '[Z]earch Recent Files ("." for repeat)', silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zg",
				"<cmd>lua require('fzf-lua').live_grep()<CR>",
				{ desc = "[Z]earch by [G]rep", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zw",
				"<cmd>lua require('fzf-lua').grep_cword()<CR>",
				{ desc = "[Z]earch current [W]ord", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zv",
				"<cmd>lua require('fzf-lua').grep_visual()<CR>",
				{ desc = "[Z]earch [V]isual Selection", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>zk",
				"<cmd>lua require('fzf-lua').keymaps()<CR>",
				{ desc = "[Z]earch [V]isual Selection", silent = true }
			)
		end,
	},
}
