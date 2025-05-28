local hxSlotComponent = [[
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

local hxLiveComponent = [[
  <.live_component module={$1} id=":$2"/>
]]

local hxComponentModule = [[
  defmodule ${1:AppWeb}.${2:Hyper}.$3 do
    use Phoenix.Component


    def ${4:basic}(assigns) do
      ~H"""
      $5 
      """
    end
  end
]]

local hxComponentWithVariants = [[
  defmodule ${1:AppWeb}.${2:Hyper}.$3 do
    use Phoenix.Component

    attr :variant, :atom, default: :basic
    def $4(assigns) do
      # case assigns[:variant] do
        # :dui1 -> dui1(assigns)
        # :dui2 -> dui2(assigns)
        # :pines1 -> pines1(assigns)
        # :pines2 -> pines2(assigns)
        # _ -> basic(assigns)
      # end
      basic(assigns)
    end

    def basic(assigns) do
      ~H"""
      $5 
      """
    end
  end
]]

return {

  -- Components
  { prefix = "cmp:fn", body = hxComponent, description = "LiveView HEEX Component" },
  { prefix = "cmp:fn:slot", body = hxSlotComponent, description = "LiveView functionComponent" },
  { prefix = "cmp:live", body = hxLiveComponent, description = "LiveView <.live_component />" },
  { prefix = "cmp:module", body = hxComponentModule, description = "HEEX Component Module" },
  {
    prefix = "cmp:module:variants",
    body = hxComponentWithVariants,
    description = "HEEX Component Module with variants",
  },
}
