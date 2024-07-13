-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

-- local l = extras.lambda
-- local d = ls.dynamic_node
-- local t = ls.text_node
-- local c = ls.choice_node

local componentTmpl = [[
defmodule {}.{} do
  use {}Web, :html
  use Phoenix.Component
end
]]

ls.add_snippets("elixir", {
	s("cmp", fmt(componentTmpl, { i(1, "ModuleName"), i(2), rep(1) })),
})
