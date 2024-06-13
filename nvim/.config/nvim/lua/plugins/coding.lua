return {
	{
		"nacro90/numb.nvim",
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{
				"gK",
				"<cmd>TWValues<cr>",
				desc = "Show tailwind CSS values",
			},
		},
		opts = {
			border = "rounded",
			show_unknown_classes = true,
			focus_preview = true,
		},
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	opts = {
	-- 		pre_hook = function()
	-- 			return vim.bo.commentstring
	-- 		end,
	-- 	},
	-- },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			-- or relative to the directory of $MYVIMRC
			-- require("luasnip.loaders.from_vscode").load({
			--   paths = "./my_snippets",
			-- })

			require("luasnip.loaders.from_lua").load({
				paths = "~/snippets",
			})
		end,
		dependencies = { "L3MON4D3/LuaSnip" },
	},
	{
		"nvimdev/template.nvim",
		cmd = { "Template", "TemProject" },
		config = function()
			require("template").setup({
				temp_dir = "~/templates",
			})
		end,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		config = function()
			require("mini.comment").setup()
		end,
	},
}
