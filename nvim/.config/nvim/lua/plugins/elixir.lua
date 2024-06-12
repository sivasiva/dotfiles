return {
	{
		"elixir-tools/elixir-tools.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local elixir = require("elixir")
			local elixirls = require("elixir.elixirls")

			elixir.setup({
				nextls = { enable = false },
				-- nextls = { enable = true, autostart = true },
				credo = { enable = false },
				-- elixirls = {
				-- 	enable = true,
				-- 	settings = elixirls.settings({
				-- 		dialyzerEnabled = false,
				-- 		enableTestLenses = false,
				-- 	}),
				-- 	on_attach = function(client, bufnr)
				-- 		vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
				-- 		vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
				-- 		vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
				-- 	end,
				-- },
				elixirls = {
					enable = true,
					-- specify a repository and branch
					-- repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
					-- branch = "mh/all-workspace-symbols", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
					-- tag = "v0.14.6", -- defaults to nil, mutually exclusive with the `branch` option

					-- alternatively, point to an existing elixir-ls installation (optional)
					-- not currently supported by elixirls, but can be a table if you wish to pass other args `{"path/to/elixirls", "--foo"}`
					-- cmd = "/usr/local/bin/elixir-ls.sh",

					-- default settings, use the `settings` function to override settings
					settings = elixirls.settings({
						dialyzerEnabled = false,
						fetchDeps = false,
						enableTestLenses = true,
						suggestSpecs = true,
					}),
					on_attach = function(client, bufnr)
						-- vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
						-- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
						-- vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
					end,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
