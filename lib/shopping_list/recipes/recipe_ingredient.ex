defmodule ShoppingList.Recipes.RecipeIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingList.Recipes.{Recipe, Ingredient}

  schema "recipe_ingredient" do
    field :quantity, :string
    belongs_to(:recipe, Recipe)
    belongs_to(:ingredient, Ingredient)

    timestamps()
  end

  @doc false
  def changeset(recipe_ingredient, attrs) do
    recipe_ingredient
    |> cast(attrs, [:quantity, :recipe_id, :ingredient_id])
    |> validate_required([:quantity, :recipe_id, :ingredient_id])
  end
end
