-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
-- local t = ls.text_node
local rep = extras.rep
-- local l = extras.lambda
-- local c = ls.choice_node
--

local schemaTmpl = [[
defmodule {}.{}.{} do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {{:id, :binary_id, autogenerate: true}}
  @foreign_key_type :binary_id
  schema "{}" do
    # field :name, :string


    # belongs_to :owner, {}.Accounts.User

    timestamps(type: :utc_datetime)
  end


  @doc false
  def changeset(model, attrs) do
    # model 
    # |> cast(attrs, [:name])
    # |> validate_required([:name])
  end

end
]]
ls.add_snippets("elixir", {
	s(
		"schema",
		fmt(schemaTmpl, { i(1, "App Name"), i(2, "Context Name"), i(3, "Model Name"), i(4, "table_name"), rep(1) })
	),
})
