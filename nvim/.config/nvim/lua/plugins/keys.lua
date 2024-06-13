return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			local wk = require("which-key")

			wk.setup()

			-- vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			-- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			-- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			-- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			-- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			-- Document existing key chains
			-- wk.register({
			-- 	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- 	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			-- 	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			-- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- 	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			-- 	-- ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			-- 	["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			-- })
			-- visual mode
			-- wk.register({
			-- 	["<leader>h"] = { "Git [H]unk" },
			-- }, { mode = "v" })

			-- keys = {
			-- 	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			-- 	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			-- 	{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			-- 	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			-- 	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			-- 	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			-- 	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			-- 	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			-- 	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			-- 	{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			-- 	{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
			-- },
			local bufferKeys = {
				p = { "<cmd>BufferLineTogglePin<cr>", "[B]uffer [p]in" },
				P = { "<cmd>BufferLineGroupClose ungrouped<cr>", "[B]uffer delete non-[P]inned" },
				o = { "<cmd>BufferLineCloseOthers<cr>", "[B]uffer close [O]thers" },
				r = { "<cmd>BufferLineCloseRight<cr>", "[B]uffer close [R]ight" },
				l = { "<cmd>BufferLineCloseLeft<cr>", "[B]uffer close [L]eft" },
			}

			local builtin = require("telescope.builtin")
			local searchKeys = {
				b = { builtin.buffers, "[S]earch [B]uffers" },
				f = { builtin.find_files, "[S]earch [F]iles" },
				g = { builtin.live_grep, "[S]earch [G]rep" },
				h = { builtin.help_tags, "[S]earch [H]elp tags" },
				k = { builtin.keymaps, "[S]earch [K]ey maps" },
				r = { builtin.resume, "[S]earch [R]esume" },
				s = { builtin.builtin, "[S]earch [S]elect Telescope" },
				w = { builtin.grep_string, "[S]earch current [W]ord" },
			}

			local projectKeys = {
				f = { "<cmd>Telescope neovim-project discover<cr>", "[P]roject [F]ind" },
				h = { "<cmd>Telescope neovim-project history<cr>", "[P]roject [H]istory" },
				l = { "<cmd>Telescope neovim-project discover<cr>", "[P]rojects [L]ist" },
				r = { "<cmd>NeovimProjectLoadRecent<cr>", "[P]roject [R]ecent" },
			}

			-- wk.register({
			-- 	["<leader>p"] = projectKeys,
			-- 	["<leader>s"] = searchKeys,
			-- 	["<leader>b"] = bufferKeys,
			-- })
		end,
	},
}
