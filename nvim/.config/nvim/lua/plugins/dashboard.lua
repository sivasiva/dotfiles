return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"ozthemagician/alpha-cowsays-nvim",
		},
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local cow = require("alpha-cowsays-nvim")

			dashboard.section.header.val = cow.cowsays()

			-- dashboard.section.header.val = {
			-- 	"                                                    ",
			-- 	" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			-- 	" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			-- 	" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			-- 	" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			-- 	" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			-- 	" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			-- 	"                                                    ",
			-- }

			dashboard.section.buttons.val = {
				dashboard.button("f", "🔦 Find file", "<cmd>Telescope find_files<CR>"),
				dashboard.button("n", "  New file", "<cmd>ene<CR>"),
				dashboard.button("s", "🔍 Search", "<cmd>Telescope live_grep<cr>"),
				dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("p", "📁 Projects", "<cmd>Telescope neovim-project discover<CR>"),
				dashboard.button("z", "🔍 FZF", "<cmd>FzfLua<cr>"),
				dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
				dashboard.button("m", "󱌣  Mason", "<cmd>Mason<CR>"),
				dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
			}

			return dashboard
		end,
		config = function(_, dashboard)
			local alpha = require("alpha")

			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Lazy-loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			alpha.setup(dashboard.opts)
		end,
	},
}
