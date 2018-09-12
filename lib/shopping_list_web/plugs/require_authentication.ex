defmodule ShoppingListWeb.Plugs.RequireAuthentication do
  import Plug.Conn
  import Phoenix.Controller

  require Logger

  def init(options), do: options

  def call(conn, _) do
    conn
    |> get_session(:current_user)
    |> case do
      nil ->
        conn
        |> redirect(to: "/login")
        |> halt
      user ->
        Logger.info fn -> "Current user logged in." end
        assign(conn, :current_user, user)
    end
  end
end
