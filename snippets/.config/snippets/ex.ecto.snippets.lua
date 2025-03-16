-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
-- local rep = extras.rep

-- local l = extras.lambda
-- local d = ls.dynamic_node
-- local t = ls.text_node
-- local c = ls.choice_node

vim.keymap.set({ "i", "s" }, "<A-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<A-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

ls.add_snippets("elixir", {
	s("ecto first", fmt(" {} = {} |> first() |> Repo.one()", { i(1, "record"), i(2, "Model") })),
	s("ecto last", fmt("{} = {} |> last() |> Repo.one()", { i(1, "record"), i(2, "Model") })),
	-- s("gen", fmt(genTmpl, { i(1, "GenServerName") })),
	-- s("cron", fmt(cronTmpl, { i(1, "MyApp.Scheduler"), rep(1) })),
	-- s("comm", fmt(commTmpl, { i(1), i(2) })),
	-- s("comm2", fmt(commChoiceTmpl, { c(1, { t("REF: "), t("TODO: "), t("NOTE: ") }), i(2), i(3) })),
	-- s("todo", fmt(todoTmpl, { i(1), i(2) })),
	-- s("ref", fmt(refTmpl, { i(1), i(2) })),
	-- s("hx", fmt(heexSigil, { i(1) })),
})
