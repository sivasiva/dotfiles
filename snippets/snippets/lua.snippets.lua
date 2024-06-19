-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local t = ls.text_node
-- local rep = extras.rep
-- local l = extras.lambda
-- local c = ls.choice_node

local func_tmpl = [[
-- {}
function {}({})
{}
end
]]

ls.add_snippets("lua", {
	s(
		"ii",
		fmt(func_tmpl, {
			i(1, "this does some function"),
			d(function(values)
				local param_str = values[1][1]
				param_str = param_str:gsub(" ", "")

				if param_str == "" then
					return ""
				end

				local params = vim.split(param_str, ",")
				local nodes = {}
			end, { 3 }),
			i(2, "name"),
			i(3),
		})
	),
})
