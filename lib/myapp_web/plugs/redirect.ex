defmodule MyAppWeb.Redirect do
  @moduledoc """
  A Plug to allow for easily doing redirects within a Plug or Phoenix router.
  """
  def init(opts) do
    if Keyword.has_key?(opts, :to) do
      opts
    else
      raise("Missing required option ':to' in redirect")
    end
  end

  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
  end
end
