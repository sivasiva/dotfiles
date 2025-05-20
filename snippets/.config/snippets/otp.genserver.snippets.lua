-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

-- local l = extras.lambda
-- local d = ls.dynamic_node
local t = ls.text_node
local c = ls.choice_node

local agentTmpl = [[
defmodule {} do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, &(&1 + 1))
  end
end
]]

local genTmpl = [[
defmodule {} do
  use GenServer

  # Callbacks

  @impl true
  def init(elements) do
    initial_state = String.split(elements, ",", trim: true)
    {{:ok, initial_state}}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state
    {{:reply, to_caller, new_state}}
  end

  @impl true
  def handle_cast({{:push, element}}, state) do
    new_state = [element | state]
    {{:noreply, new_state}}
  end
end
]]

local gen2 = [[
defmodule <> do
  use GenServer

  # ----------------------------------------------------
  # Client API 
  # ----------------------------------------------------
  def start_link(_), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  def add(k, v), do: GenServer.cast(__MODULE__, {:add, {k, v}})
  def get(k), do: GenServer.call(__MODULE__, {:get, k})
  def all(), do: GenServer.call(__MODULE__, {:all})

  # ----------------------------------------------------
  # Server API 
  # ----------------------------------------------------
  def init(_), do: {:ok, %{}}

  # Sync Calls, reply
  # ----------------------------------------------------
  def handle_call({:get, k}, _, state) do
    {:reply, Map.get(state, k), state}
  end

  def handle_call({:all}, _, state) do
    {:reply, state, state}
  end

  # Async Calls, noreply
  # ----------------------------------------------------
  def handle_cast({:add, {k, v}}, state) do
    {:noreply, Map.put(state, k, v)}
  end
end

]]

local cronTmpl = [[
# https://stackoverflow.com/a/32097971
defmodule {} do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{{}})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {{:ok, state}}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    schedule_work() # Reschedule once more
    {{:noreply, state}}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 2 * 60 * 60 * 1000) # In 2 hours
  end
end


~S"""
children = [
  {}
]

Supervisor.start_link(children, strategy: :one_for_one)
"""
]]

local commChoiceTmpl = [[
# ----------------------------------------------------
# {} {}
# ----------------------------------------------------
{}
]]

local commTmpl = [[
# ----------------------------------------------------
# {} 
# ----------------------------------------------------
{}
]]

local todoTmpl = [[
# ----------------------------------------------------
# TODO: {}
# ----------------------------------------------------
{}
]]

local refTmpl = [[
# ----------------------------------------------------
# REF: {}
# ----------------------------------------------------
{}
]]

local heexSigil = [[
~H"""
  {}
"""
]]

ls.add_snippets("elixir", {
	s("ag", fmt(agentTmpl, { i(1, "AgentName") })),
	s("gen", fmt(genTmpl, { i(1, "GenServerName") })),
	s("cron", fmt(cronTmpl, { i(1, "MyApp.Scheduler"), rep(1) })),
	s("comm", fmt(commTmpl, { i(1), i(2) })),
	s("comm2", fmt(commChoiceTmpl, { c(1, { t("REF: "), t("TODO: "), t("NOTE: ") }), i(2), i(3) })),
	s("todo", fmt(todoTmpl, { i(1), i(2) })),
	s("ref", fmt(refTmpl, { i(1), i(2) })),
	s("hx", fmt(heexSigil, { i(1) })),
	s("gs", fmt(gen2, { i(1) }, { delimiters = "<>" })),
})
