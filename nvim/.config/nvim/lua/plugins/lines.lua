return {
	{
		"lukas-reineke/virt-column.nvim",
		opts = {},
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			disabled_filetypes = {
				"netrw",
				"NvimTree",
				"Lazy",
				"mason",
				"help",
				"text",
				"markdown",
				"tex",
				"html",
			},
			scope = "window",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {},
			},
		},
		init = function()
			vim.opt.showmode = false
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				separator_style = "slant",
				mode = "tabs",
				offsets = {
					{
						filetype = "NvimTree",
						text = " File Explorer",
						highlight = "Directory",
						separator = false,
					},
				},
			},
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		theme = "catppuccin",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			show_dirname = false,
			show_basename = false,
		},
	},
	{
		"yamatsum/nvim-cursorline",
		opts = {
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
			cursorline = {
				enable = false,
			},
		},
	},
}
