return {
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
}
