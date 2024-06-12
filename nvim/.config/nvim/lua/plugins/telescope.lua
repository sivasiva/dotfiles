return {

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
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			-- local builtin = require("telescope.builtin")
			-- vim.keymap.set("n", "<M-p>", builtin.find_files, {})
			-- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			-- From Kickstarter

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<c-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
		end,
	},
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				-- ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
				["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			})
			-- visual mode
			require("which-key").register({
				["<leader>h"] = { "Git [H]unk" },
			}, { mode = "v" })
		end,
	},
	-- {
	-- 	"folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	keys = {
	-- 		{
	-- 			"s",
	-- 			mode = { "n", "x", "o" },
	-- 			function()
	-- 				require("flash").jump()
	-- 			end,
	-- 			desc = "Flash",
	-- 		},
	-- 		{
	-- 			"S",
	-- 			mode = { "n", "x", "o" },
	-- 			function()
	-- 				require("flash").treesitter()
	-- 			end,
	-- 			desc = "Flash Treesitter",
	-- 		},
	-- 		{
	-- 			"r",
	-- 			mode = "o",
	-- 			function()
	-- 				require("flash").remote()
	-- 			end,
	-- 			desc = "Remote Flash",
	-- 		},
	-- 		{
	-- 			"R",
	-- 			mode = { "o", "x" },
	-- 			function()
	-- 				require("flash").treesitter_search()
	-- 			end,
	-- 			desc = "Treesitter Search",
	-- 		},
	-- 		{
	-- 			"<c-s>",
	-- 			mode = { "c" },
	-- 			function()
	-- 				require("flash").toggle()
	-- 			end,
	-- 			desc = "Toggle Flash Search",
	-- 		},
	-- 	},
	-- },
}
