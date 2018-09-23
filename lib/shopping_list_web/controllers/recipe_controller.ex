defmodule ShoppingListWeb.RecipeController do
  use ShoppingListWeb, :controller

  alias ShoppingList.Recipes
  alias ShoppingList.Recipes.Recipe

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    recipes = Recipes.list_recipes_for_user(current_user)
    render(conn, "index.html", recipes: recipes)
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Recipes.change_recipe(%Recipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"recipe" => recipe_params}) do
    recipe_params
    |> Map.merge(%{"user_id" => user.id})
    |> Recipes.create_recipe()
    |> case do
      {:ok, _recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: "/recipe")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    changeset = Recipes.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Recipes.get_recipe!(id)
    # recipe_path(conn, :show, recipe)
    case Recipes.update_recipe(recipe, recipe_params) do
      {:ok, _recipe} ->
        conn
        |> put_flash(:info, "recipe updated successfully.")
        |> redirect(to: "/recipe")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    {:ok, _recipe} = Recipes.delete_recipe(recipe)

    conn
    |> put_flash(:info, "recipe deleted successfully.")
    |> redirect(to: "/recipe")
  end
end
