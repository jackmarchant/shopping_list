defmodule ShoppingListWeb.PageView do
  use ShoppingListWeb, :view

  import Plug.Conn

  def get_user(conn) do
    get_session(conn, :current_user)
  end
end
