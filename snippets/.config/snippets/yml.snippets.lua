-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local i = ls.insert_node
-- local d = ls.dynamic_node
-- local extras = require("luasnip.extras")
-- local rep = extras.rep
-- local l = extras.lambda
local c = ls.choice_node
--

local comment_block = [[
# -------------------------------------
# {comment}
# -------------------------------------
]]

ls.add_snippets("yaml", {
	-- s("comm", fmt(comment_block, { c(1, { t(""), t("TODO:"), t("NOTE:") }) })),
	s(
		"comm",
		fmt(comment_block, {
			comment = c(1, { t("NOTE:"), t("TODO:"), t("") }),
		})
	),
})
