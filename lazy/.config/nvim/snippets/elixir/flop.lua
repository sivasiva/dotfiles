local flop = [[
  case Flop.validate_and_run(${1:Service}, params, for: $1) do
    {:ok, { ${2:services}, meta} ->
      %{$2: $2, meta: meta}

    {:error, meta} ->
      %{$2: [], meta: meta}
  end
]]

local flopSchema = [[
  @derive {
    Flop.Schema,
    filterable: [:name], sortable: [:name], default_limit: 5
  }
]]

return {
  { prefix = "flop:schema", body = flopSchema, description = "Flop schema" },
  { prefix = "flop:setup", body = flop, description = "Flop setup" },
}
