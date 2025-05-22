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

local inspect = [[
<pre><%= inspect(assigns, pretty: true) %></pre>
]]

local hxBlock = [[
  <%= $1 do %>
   $2
  <% end %>
]]

local ifHeex = [[
  <%= if $1 do %>
   $2
  <% end %>
]]

local elseHeex = [[
  <% else %>
  $1 
]]

local ifElement = [[
  <$1 :if={$1}>$2</$1>
]]

local preHX = [[
<pre>
  <%= inspect(@$1, pretty: true) %>
</pre>
]]

local list = [[
<ul>
  <li :for={item <- @$1}>
  <%= item.name %>
  </li>
</ul>
]]

local forHX = [[
  <%= for $1 <- @${2:list} do %>
   $3 
  <% end %>
]]

local hxLinkPatch = [[
  <.link patch={~p"/$1"}>$2</.link>
]]

local linkNavigate = [[
  <.link navigate={{~p"/$1"}}>$2</.link>
]]

local liHX = [[
  <li :if={$1}>$2</li>
]]

return {

  -- Components
  { prefix = "cmp:hx", body = hxComponent, description = "LiveView HEEX Component" },
  { prefix = "cmp:live", body = liveComponentHX, description = "LiveView <.live_component />" },
  { prefix = "cmp:fn", body = functionComponent, description = "LiveView functionComponent" },

  -- Debugging
  { prefix = "hx:pre", body = preHX, description = "HEEX pre element" },
  { prefix = "hx:inspect:assigns", body = inspect, description = "HEEX IO.inspect to debug assigns" },

  -- Control Flow
  { prefix = "hx:else", body = elseHeex, description = "HEEX else block" },
  { prefix = "hx:forLoop", body = forHX, description = "HEEX for loop block" },
  { prefix = "hx:if", body = ifHeex, description = "HEEX if block" },

  -- Links
  { prefix = "hx:link:if", body = liHX, description = "HEEX link with :if clause" },
  { prefix = "hx:link:nav", body = linkNavigate, description = "HEEX link with navigate" },
  { prefix = "hx:link:patch", body = hxLinkPatch, description = "HEEX link with patch" },

  { prefix = "hx:element:if", body = ifElement, description = "HEEX element with :if clause" },
  { prefix = "hx:list", body = list, description = "HEEX ul list" },
  { prefix = "=", body = hxBlock, description = "<%= %> Block" },
}
