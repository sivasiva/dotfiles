local liveViewRoutes = [[
  live "/${1:toys}", ${2:Toys}Live.Index, :index
  live "/$1/new", $2Live.Index, :new
  live "/$1/:id/edit", $2Live.Index, :edit
  live "/$1/:id", $2Live.Show, :show
  live "/$1/:id/show/edit", $2Live.Show, :edit
]]

local lvRoutesv1_8 = [[
  live "/${1:toys", ${2:Toys}Live.Index, :index
  live "/$1/new", $2Live.Form, :new
  live "/$1/:id", $2Live.Show, :show
  live "/$1/:id/edit", $2Live.Form, :edit
]]

local lvModule = [[
  defmodule ${1:AppWeb}.${2:Toys}Live do
    use $1, :live_view

    def mount(_params, _session, socket) do
      # initial state goes here like so:
      # socket = assign(socket, key1: "value1", key2: "value2")
      # use https://hexdocs.pm/phoenix_live_view/dom-patching.html#temporary-assigns to avoid expensive data loads
      { :ok, socket }
    end

    # handle_params is rendered immediately after `mount`
    # and is responsible for live route changes based on `id` or other params
    # def handle_params(%{ "id" => id}, _uri, socket) do
    # item = Items.get_item(id)
    # {:noreply, socket}
    # end

    # catch-all `handle_params`
    def handle_params(_params, _uri, socket) do
      {:noreply, socket}
    end

    def render(assigns) do
      # assigns vars are available within H templates as `@key1`, `@key2`
      ~H"""
        <div>$1.$2Live</div>
      """
    end

    def handle_event("change", _payload, socket) do
      {:noreply, socket}
    end

    # use this to handle non-user events
    # like Process-generated events (like the socket process `self()`)
    # example: :timer.send_interval(1000, self(), :tick)
    #
    # this sends a :tick event, every 1000ms (1 second)
    #
    # def handle_info(:tick, socket) do
    #  {:noreply, socket}
    # end
  end
]]

local lvHandleEvent = [[
def handle_event("$1", payload, socket) do
  # socket = update(socket, :item, $($1 + 1))
  socket = assign(socket, key: "value")

  {:noreply, socket}
end
]]

local lvHandleEventPushPatch = [[
def handle_event("select-per-page", %{"per-page" => per_page }, socket) do
 params = %{socket.assigns.options | per_page: per_page }
  socket = push_patch(socket, to: ~p"/$1?#{params}")

  {:noreply, socket}
end
]]

local lvHandleParams = [[
def handle_params(_params, _uri, socket) do
$1
{:noreply, socket}
end
]]

return {
  { prefix = "lv:module", body = lvModule, description = "LiveView controller" },
  { prefix = "lv:router:v1.8", body = lvRoutesv1_8, description = "LiveView routes Phoenix v1.8" },
  -- { prefix = "lv:router:v1.7", body = liveViewRoutes, description = "LiveView routes Phoenix v1.7" },

  -- Events
  { prefix = "lv:handleEvent", body = lvHandleEvent, description = "handle_event" },
  { prefix = "lv:handleParams", body = lvHandleParams, description = "handle_params fn" },
  { prefix = "lv:handlePush", body = lvHandleEventPushPatch, description = "handle_event push_patch" },
}
