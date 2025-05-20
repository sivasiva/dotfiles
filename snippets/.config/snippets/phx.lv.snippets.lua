local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep
local f = ls.function_node
-- local c = ls.choice_node
-- local l = extras.lambda
-- local d = ls.dynamic_node

-- https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
-- ls.config.set_config({
--   enable_autosnippets = true,
-- })
--
local flop = [[
  case Flop.validate_and_run({}, params, for: {}) do
    {{:ok, {{ {}, meta}} ->
      %{{{}: {}, meta: meta}}

    {{:error, meta}} ->
      %{{{}: [], meta: meta}}
  end
]]

local sigilH = [[
~H"""
  {}
"""
]]

local map = [[%{{ "{}" => {} }}]]

local liveView = [[
  defmodule {}.{}Live do
    use {}, :live_view

    def mount(_params, _session, socket) do
      # initial state goes here like so:
      # socket = assign(socket, key1: "value1", key2: "value2")
      # use https://hexdocs.pm/phoenix_live_view/dom-patching.html#temporary-assigns to avoid expensive data loads
      {{ :ok, socket }}
    end

    # handle_params is rendered immediately after `mount`
    # and is responsible for live route changes based on `id` or other params
    # def handle_params(%{{ "id" => id}}, _uri, socket) do
    # item = Items.get_item(id)
    # {{:noreply, socket}}
    # end

    # catch-all `handle_params`
    def handle_params(_params, _uri, socket) do
      {{:noreply, socket}}
    end

    def render(assigns) do
      # assigns vars are available within H templates as `@key1`, `@key2`
      ~H"""
        <div>{}.{}Live</div>
      """
    end

    def handle_event("change", _payload, socket) do
      {{:noreply, socket}}
    end

    # use this to handle non-user events
    # like Process-generated events (like the socket process `self()`)
    # example: :timer.send_interval(1000, self(), :tick)
    #
    # this sends a :tick event, every 1000ms (1 second)
    #
    # def handle_info(:tick, socket) do
    #  {{:noreply, socket}}
    # end
  end
]]

local handleEvent = [[
def handle_event("{}", payload, socket) do
  # socket = update(socket, :item, $($1 + 1))
  socket = assign(socket, key: "value")

  {{:noreply, socket}}
end
]]

local handleEventPushPatch = [[
def handle_event("select-per-page", %{{"per-page" => per_page }}, socket) do
 params = %{{socket.assigns.options | per_page: per_page }}
  socket = push_patch(socket, to: ~p"/{}?#{{params}}")

  {{:noreply, socket}}
end
]]

local functionComponent = [[
slot :inner_block, required: true
def {}(assigns) do
  ~H"""
    <div class="{}">
      <%= render_slot(@inner_block) %>
    </div>
  """
end
]]

local hxComponent = [[
def {}(assigns) do
  ~H"""
    {}
  """
end
]]

local forHX = [[
  <%= for {} <- @{} do %>
  {}
  <% end %>
]]

local hxLinkPatch = [[
  <.link patch={{~p"/{}"}}>{}</.link>
]]

local linkNavigate = [[
  <.link navigate={{~p"/{}"}}>{}</.link>
]]

local liHX = [[
  <li :if={{{}}}>{}</li>
]]

local hpFn = [[
def handle_params(_params, _uri, socket) do
{}
{{:noreply, socket}}
end
]]

local ifElement = [[
  <{} :if={{{}}}>{}</{}>
]]

local preHX = [[
<pre>
  <%= inspect(@{}, pretty: true) %>
</pre>
]]

local liveComponentHX = [[
  <.live_component module={{{}}} id=":{}"/>
]]

local inspector = [[
  IO.inspect({}, label: ">>>>>>>>>>>>>>>>> {}")
]]

local list = [[
<ul>
  <li :for={{item <- @{}}}>
  <%= item.name %>
  </li>
</ul>
]]

local inspect = [[
<pre><%= inspect(assigns, pretty: true) %></pre>
]]

local ifHeex = [[
  <%= if {} do %>
  <% end %>
]]

local elseHeex = [[
  <% else %>
  {}
]]

local flopSchema = [[
  @derive {{
    Flop.Schema,
    filterable: [:name], sortable: [:name], default_limit: 5
  }}
]]

ls.add_snippets(
	"elixir",
	{
		s("lv:handle_event", fmt(handleEvent, { i(1, "eventName") })),
		s("lv:handle_params", fmt(hpFn, { i(1) })),
		s("insl", fmt([[IO.inspect({}, label: "{}")]], { i(1), rep(1) })),
		s("ins", fmt([[IO.inspect({}, label: "{}")]], { i(1), rep(1) })),
		s("hx:ul-li-loop", fmt(list, { i(1, "items") })),
		s("lv:module", fmt(liveView, { i(1, "AppName"), i(2, "Module"), rep(1), rep(1), rep(2) })),
		s("hx:map", fmt(map, { i(1), rep(1) })),
		s("fmt5", fmta("foo() { return <>; }", i(1, "x"))),
		-- s("flop", fmt(flop, { i(1, "schema"), rep(1), i(3) }), { delimiters = "%%" }),
		s("flop:context", fmt(flop, { i(1, "schema"), rep(1), rep(1), rep(1), rep(1), rep(1) })),
		s("flop:schema", fmt(flopSchema, {})),

		-- HEEX Templates
		s("hx:%", fmt("<% {} %>", { i(1) })),
		s("hx:=", fmt("<%= {} %>", { i(1) })),
		s("hx:a:navigate", fmt(linkNavigate, { i(1), i(2) })),
		s("hx:a:patch", fmt(hxLinkPatch, { i(1), i(2) })),
		s("hx:component", fmt(functionComponent, { i(1, "componentName"), rep(1) })),
		s("hx:def_comp", fmt(hxComponent, { i(1), i(2) })),
		s("hx:element:li", fmt(liHX, { i(1), i(2) })),
		s("hx:element:pre", fmt(preHX, { i(1) })),
		s("hx:else", fmt(elseHeex, { i(1, "else block") })),
		s("hx:for", fmt(forHX, { i(1, "item"), i(2, "items"), i(3) })),
		s("hx:if", fmt(ifHeex, { i(1, "condition") })),
		s("hx:ifElement", fmt(ifElement, { i(1, "div"), i(2), i(3), rep(1) })),
		s("hx:inspect", fmt(inspect, {})),
		s("hx:live_component", fmt(liveComponentHX, { i(1), i(2) })),
		s("hx:push_patch", fmt(handleEventPushPatch, { i(1, "route") })),
		s("hx:render_slot", t("<%= render_slot(@inner_block) %>")),
		s("hx:~", fmt(sigilH, { i(1) })),
	}
	-- https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
	-- { type = "autosnippets" }
)
