-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
-- local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
local t = ls.text_node
-- local rep = extras.rep
-- local l = extras.lambda
local c = ls.choice_node
--

local repo = [[
- [REPO]({})
]]
local link = [[
- [{}]({})
]]

ls.add_snippets("markdown", {
	-- s("li", fmt(link, { i(1), i(2) })),
	s("repo", fmt(repo, { i(1) })),
	s("li", fmt("- [{}]({})", { c(1, { t("SUPER"), t("GOLD"), t("CODE"), t("Nice!") }), i(2) })),
	s("-", fmt("- [{}]({})", { i(1), i(2) })),
})
