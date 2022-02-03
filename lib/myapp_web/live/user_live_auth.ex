defmodule MyAppWeb.UserLiveAuth do
  alias MyAppWeb.Router.Helpers, as: Routes
  import Phoenix.LiveView

  alias MyApp.Accounts

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token!(user_token)
      end)

    if socket.assigns.current_user.confirmed_at do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: Routes.user_session_path(socket, :new))}
    end
  end

  def mount(_params, _session, socket) do
    {:halt, redirect(socket, to: Routes.user_session_path(socket, :new))}
  end
end
