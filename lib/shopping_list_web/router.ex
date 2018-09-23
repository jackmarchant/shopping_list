defmodule ShoppingListWeb.Router do
  use ShoppingListWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug ShoppingListWeb.Plugs.RequireAuthentication
  end

  scope "/", ShoppingListWeb do
    pipe_through :browser

    get "/", PageController, :index

    # user session
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete("/logout", SessionController, :destroy)
  end

  scope "/", ShoppingListWeb do
    pipe_through [:browser, :authenticated]

    get "/dashboard", DashboardController, :index

    resources("/user", UserController)
    resources("/recipe", RecipeController)
  end
end
