local inxController = [[
defmodule AppWeb.${1:Demo}Controller do
  use AppWeb, :controller

  def index(conn, _params) do
    conn
    |> assign_prop(:place, "World")
    |> render_inertia("$1")
  end
end
]]

return {
  { prefix = "in:controller", body = inxController, description = "Inertia Controller" },
}
