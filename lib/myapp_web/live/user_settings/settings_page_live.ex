defmodule MyAppWeb.UserSettings.SettingsPageLive do
  use MyAppWeb, :live_view
  # on_mount MyAppWeb.UserLiveAuth

  alias MyApp.Accounts
  alias MyAppWeb.UserSettingsView

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:email_changeset, Accounts.change_user_email(socket.assigns.current_user))
      |> assign(:password_changeset, Accounts.change_user_password(socket.assigns.current_user))

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    UserSettingsView.render("edit.html", assigns)
  end
end
