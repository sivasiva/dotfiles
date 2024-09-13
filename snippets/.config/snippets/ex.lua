-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
-- local c = ls.choice_node
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep

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

local stringInterpolator = [[
#{{{}}}
]]

ls.add_snippets("elixir", {
	s("#", fmt(stringInterpolator, { i(1) })),
	s("ag", fmt(agentTmpl, { i(1, "AgentName") })),
	s("gen", fmt(genTmpl, { i(1, "GenServerName") })),
	s("cron", fmt(cronTmpl, { i(1, "MyApp.Scheduler"), rep(1) })),
})
