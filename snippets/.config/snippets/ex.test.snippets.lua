local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep
local c = ls.choice_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local l = extras.lambda

local liveViewTest = [[
test "{}", %{{conn: conn }} do
  {{:ok, view, _html}} = live(conn, ~p"/{}")

  assert has_element?(view, "#count", "1") 
  {}
end
]]

local liveViewRoutes = [[
  live "/{}", {}Live.Index, :index
  live "/{}/new", {}Live.Index, :new
  live "/{}/:id/edit", {}Live.Index, :edit
  live "/{}/:id", {}Live.Show, :show
  live "/{}/:id/show/edit", {}Live.Show, :edit
]]

local siva = [[
  result = {}
  assert result == "siva"
]]

ls.add_snippets("elixir", {
	s("lvt", fmt(liveViewTest, { i(1, "renders live view"), i(2, "route"), i() })),
	s(
		"lvr",
		fmt(liveViewRoutes, {
			i(1, "collection"),
			i(2, "Module"),
			rep(1),
			rep(2),
			rep(1),
			rep(2),
			rep(1),
			rep(2),
			rep(1),
			rep(2),
		})
	),
	s("siva", fmt(siva, { i(1) })),
})
