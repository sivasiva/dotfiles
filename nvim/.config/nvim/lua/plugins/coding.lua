return {
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
		"nacro90/numb.nvim",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			pre_hook = function()
				return vim.bo.commentstring
			end,
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- branch = "v3",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		keys = {
			{ "<Leader>n", ":NoNeckPain<CR>" },
		},
	},
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		config = true,
	},
}
