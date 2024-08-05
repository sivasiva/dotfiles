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

local mix1Tmpl = [[
defmodule Mix.Tasks.Gen{} do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start", [])

    # Tx.GenTx.generate_csv()
  end
end

]]

local mixCopyTmpl = [[
defmodule Mix.Tasks.Seed{}Data do
  use Mix.Task

  def run(path) do
    Mix.Task.run("app.start", [])

    opts = App.Repo.config()
    {{:ok, pid}} = Postgrex.start_link(opts)

    Postgrex.transaction(
      pid, 
      fn conn ->
        stream =
          Postgrex.stream(
            conn,
            "COPY locations(name,latitude,longitude) FROM STDIN CSV HEADER DELIMITER ','",
            []
          )

        Enum.into(File.stream!(path, [:trim_bom]), stream)
      end,
      timeout: :infinity
    )
  end
end
]]

ls.add_snippets("elixir", {
	s("cmp", fmt(componentTmpl, { i(1, "ModuleName"), i(2), rep(1) })),
	s("mix gen", fmt(mix1Tmpl, { i(1, "ModuleName") })),
	-- s("mix migrate", fmt(mix2Tmpl, {})),
	s("mix seed", fmt(mixCopyTmpl, { i(1, "ModuleName") })),
})
