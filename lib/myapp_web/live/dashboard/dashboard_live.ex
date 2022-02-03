defmodule MyAppWeb.Dashboard.DashboardLive do
  use MyAppWeb, :live_view
  # on_mount MyAppWeb.UserLiveAuth

  alias MyAppWeb.DashboardView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    DashboardView.render("index.html", assigns)
  end
end
