-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local c = ls.choice_node
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local d = ls.dynamic_node
local l = extras.lambda
local rep = extras.rep

local func_tmpl = [[
-- {}
function {}({})
{}
end
]]

local snips_setup = [[
local ls = require("luasnip")
local c = ls.choice_node
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local d = ls.dynamic_node
local l = extras.lambda
local rep = extras.rep
]]

local block = [[
-- -------------------------------------------------
-- {}
-- -------------------------------------------------
]]

-- -------------------------------------------------
-- LuaSnip choice_node keymaps
-- REF: https://www.reddit.com/r/neovim/comments/tbtiy9/comment/i0bje36/
-- -------------------------------------------------
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

local func_tmpl = [[
-- {}
function {}({})
{}
end
]]

local snFile = [[
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
--
ls.add_snippets("{}", {{
}})

]]

ls.add_snippets("lua", {
	s("comm", fmt(block, { i(1, "comment") })),
	s(
		"fmt1",
		fmt("To {title} {} {}.", {
			i(2, "Name"),
			i(3, "Surname"),
			title = c(1, { t("Mr."), t("Ms.") }),
		})
	),
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
	s("snFile", fmt(snFile, { i(1) })),
})
