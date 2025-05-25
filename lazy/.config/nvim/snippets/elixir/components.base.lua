local functionComponent = [[
slot :inner_block, required: true
def $1(assigns) do
  ~H"""
    <div class="$2">
      <%= render_slot(@inner_block) %>
    </div>
  """
end
]]

local hxComponent = [[
def $1(assigns) do
  ~H"""
   $2 
  """
end
]]

local liveComponentHX = [[
  <.live_component module={$1} id=":$2"/>
]]

return {

  -- Components
  { prefix = "cmp:hx", body = hxComponent, description = "LiveView HEEX Component" },
  { prefix = "cmp:live", body = liveComponentHX, description = "LiveView <.live_component />" },
  { prefix = "cmp:fn", body = functionComponent, description = "LiveView functionComponent" },
}
