defmodule MyAppWeb.UserAdminLiveAuth do
  alias MyAppWeb.Router.Helpers, as: Routes
  import Phoenix.LiveView

  alias MyApp.Accounts

  def on_mount(_arg, _params, %{"user_token" => user_token} = _session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token!(user_token)
      end)

    if socket.assigns.current_user.role == "internal_admin" do
      {:cont, socket}
    else
      socket = put_flash(socket, :error, "You do not have access to this page.")
      {:halt, socket}
    end
  end

  def on_mount(_arg, _params, _session, socket) do
    {:halt, redirect(socket, to: Routes.user_session_path(socket, :new))}
  end
end
