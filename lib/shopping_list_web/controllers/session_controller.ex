defmodule ShoppingListWeb.SessionController do
  use ShoppingListWeb, :controller

  alias ShoppingList.Accounts.User
  alias ShoppingList.Accounts

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    email
    |> Accounts.AuthenticateUser.execute(password)
    |> case do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> redirect(to: "/dashboard")
      {:error, _} ->
        conn
        |> put_flash(:error, "Sorry, that didn't seem to work. Please try again.")
        |> render("new.html", changeset: Accounts.change_user(%User{email: email}))
    end
  end

  def destroy(conn, _) do
    conn
    |> put_session(:current_user, nil)
    |> redirect(to: "/login")
  end
end
