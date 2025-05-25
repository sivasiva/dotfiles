local hxInspect = [[
<pre><%= inspect(assigns, pretty: true) %></pre>
]]

local hxBlock = [[
  <%= $1 do %>
   $2
  <% end %>
]]

local hxIf = [[
  <%= if $1 do %>
   $2
  <% end %>
]]

local hxElse = [[
  <% else %>
  $1 
]]

local hxIfEl = [[
  <$1 :if={$1}>$2</$1>
]]

local hxPre = [[
<pre>
  <%= inspect(@$1, pretty: true) %>
</pre>
]]

local hxUlList = [[
<ul>
  <li :for={item <- @$1}>
  <%= item.name %>
  </li>
</ul>
]]

local hxFor = [[
  <%= for $1 <- @${2:list} do %>
   $3 
  <% end %>
]]

local hxLinkPatch = [[
  <.link patch={~p"/$1"}>$2</.link>
]]

local hxLinkNavigate = [[
  <.link navigate={{~p"/$1"}}>$2</.link>
]]

local hxLi = [[
  <li :if={$1}>$2</li>
]]

local hxDefaultSlot = [[
<!-- REF: https://fly.io/phoenix-files/function-components/ -->
{ render_slot(@${1:inner_block}) }
]]

local hxNamedSlot = [[
<!-- https://fly.io/phoenix-files/function-components/#named-slots -->
  <:${1:name_of_slot>
    $2
  </$1>
]]

return {
  -- Debugging
  { prefix = "hx:pre", body = hxPre, description = "HEEX <pre>" },
  { prefix = "hx:inspect:assigns", body = hxInspect, description = "HEEX IO.inspect to debug assigns" },

  -- Control Flow
  { prefix = "hx:else", body = hxElse, description = "HEEX else block" },
  { prefix = "hx:forLoop", body = hxFor, description = "HEEX for loop block" },
  { prefix = "hx:if", body = hxIf, description = "HEEX if block" },

  -- Links
  { prefix = "hx:link:if", body = hxLi, description = "HEEX link with :if clause" },
  { prefix = "hx:link:nav", body = hxLinkNavigate, description = "HEEX link with navigate" },
  { prefix = "hx:link:patch", body = hxLinkPatch, description = "HEEX link with patch" },

  { prefix = "hx:element:if", body = hxIfEl, description = "HEEX element with :if clause" },
  { prefix = "hx:list", body = hxUlList, description = "HEEX ul > li" },
  { prefix = "=", body = hxBlock, description = "<%= %> Block" },
  { prefix = "hx:slot:default", body = hxDefaultSlot, description = "{ render_slot(@inner_block) }" },
}
