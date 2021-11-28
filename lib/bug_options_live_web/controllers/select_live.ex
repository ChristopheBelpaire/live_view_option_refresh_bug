defmodule BugOptionsLiveWeb.SelectLive do
  use BugOptionsLiveWeb, :live_view

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <%= Enum.map(@roles, fn({role, id}) -> role end) |> Enum.join(",") %>
    <.form let={form} for={:select} phx-change="validate" phx-validate="validate">
      <%= multiple_select(form, :roles, @roles) %>
    </.form>
    """
  end

  def mount(_params, _p, socket) do
    {:ok, assign(socket, roles: ["Admin": "1", "Power User": "2", "Basic User": "3"])}
  end

  def handle_event("validate", %{"select" => %{"roles" => [role_id]}}, socket) do
    IO.inspect(role_id)
    roles = Enum.reject(socket.assigns.roles, fn({role, id})-> id == role_id end)
    IO.inspect(roles)
    {:noreply, assign(socket, roles: roles)}
  end
end
