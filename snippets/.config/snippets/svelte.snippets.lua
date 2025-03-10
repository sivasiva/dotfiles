-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local extras = require("luasnip.extras")
-- local t = ls.text_node
-- local rep = extras.rep
-- local l = extras.lambda
-- local c = ls.choice_node
--

local page_server_load_bracket = [[
export const load: PageServerLoad = async ({ locals, url, params }: ServerLoadEvent) => { 
  return { []: "world"}
}
]]

local page_server_load = [[
export const load: PageServerLoad = async ({{ locals, url, params }}: ServerLoadEvent) => {{ 
  return {{ {1}: "world"}}
}}
]]

local heexSigil = [[
~H"""
  {}
"""
]]

ls.add_snippets("svelte", {
	s("psload", fmt(page_server_load, { i(1) })),
	s("psload", fmt(page_server_load_bracket, { i(1) }, { delimiters = "[]" })),
	s("hx", fmt(heexSigil, { i(1) })),
})
