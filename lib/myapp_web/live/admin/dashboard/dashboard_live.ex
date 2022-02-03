defmodule MyAppWeb.Admin.Dashboard.DashboardLive do
  use MyAppWeb, :live_view

  @impl true
  def mount(%{"page" => page} = _params, _session, socket) do
    socket = assign(socket, :page, page)
    # complete_mount(socket)
    {:noreply, socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :page, 1)
    # complete_mount(socket)
    {:noreply, socket}
  end

  # defp complete_mount(socket) do
  #   if connected?(socket), do: Scannables.subscribe()

  #   {total, recent_track_events} = Scannables.get_recent_track_events()
  #   pagination = Paginations.get_pagination_info(recent_track_events, total)

  #   {:ok,
  #    assign(socket, recent_track_events: recent_track_events, pagination: pagination, total: total)}
  # end

  # @impl true
  # def handle_info({:track_event_created, event}, socket) do
  #   socket =
  #     socket
  #     |> update(:recent_track_events, fn track_events ->
  #       track_events = [event | track_events]

  #       if length(track_events) > Paginations.default_page_size() do
  #         List.delete_at(track_events, length(track_events) - 1)
  #       else
  #         track_events
  #       end
  #     end)

  #   socket =
  #     assign(
  #       socket,
  #       :pagination,
  #       Paginations.get_pagination_info(
  #         socket.assigns.recent_track_events,
  #         socket.assigns.total + 1
  #       )
  #     )

  #   socket = assign(socket, :total, socket.assigns.total + 1)

  #   {:noreply, socket}
  # end
end
