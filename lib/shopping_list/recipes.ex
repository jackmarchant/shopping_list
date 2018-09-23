defmodule ShoppingList.Recipes do
  @moduledoc """
  The Recipes context.
  """
  import Ecto.Query, warn: false
  alias ShoppingList.Repo
  alias ShoppingList.Recipes.{Recipe, Ingredient}

  @doc """
  Returns the list of recipe for the recipe.

  ## Examples

      iex> list_recipes_for_user(%{user_id: 123})
      [%Recipe{user_id: 123}, ...]

  """
  def list_recipes_for_user(%{id: user_id}) do
    Recipe
    |> where([r], r.user_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  Returns a list of all available ingredients

  ## Examples
      iex> list_available_ingredients()
      [%Ingredient{}, ...]
  """
  def list_available_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %Recipe{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id) do
    Recipe
    |> Repo.get!(id)
    |> Repo.preload([:ingredients])
  end

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{})

  def create_recipe(%{"ingredients" => ids} = attrs) do
    ingredients =
      Ingredient
      |> where([i], i.id in ^ids)
      |> Repo.all()

    updated_attrs = Map.merge(attrs, %{"ingredients" => ingredients})

    %Recipe{}
    |> Recipe.changeset(updated_attrs)
    |> Repo.insert()
  end

  def create_recipe(attrs) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, %{"ingredients" => ids} = attrs) do
    ingredients =
      Ingredient
      |> where([i], i.id in ^ids)
      |> Repo.all()

    updated_attrs = Map.merge(attrs, %{"ingredients" => ingredients})

    recipe
    |> Recipe.changeset(updated_attrs)
    |> Repo.update()
    |> IO.inspect()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end
end
