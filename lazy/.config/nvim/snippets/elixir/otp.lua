local agentTmpl = [[
defmodule ${1:Name} do
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
defmodule ${1:GenServerName} do
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
defmodule ${1:} do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{$2})
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
 # $3 
]

Supervisor.start_link(children, strategy: :one_for_one)
"""
]]
return {
  { prefix = "otp:agent", body = agentTmpl, description = "Agent Template" },
  { prefix = "otp:genServer", body = genTmpl, description = "GenServer" },
  { prefix = "otp:cron", body = cronTmpl, description = "cron GenServer" },
}
