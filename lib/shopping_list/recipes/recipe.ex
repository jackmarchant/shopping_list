defmodule ShoppingList.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingList.Accounts.User
  alias ShoppingList.Recipes.Ingredient
  alias ShoppingList.Repo

  schema "recipe" do
    field :name, :string
    field :steps, :string

    belongs_to(:user, User)
    many_to_many(:ingredients, Ingredient, join_through: "recipe_ingredient", on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    IO.inspect(attrs)

    recipe
    |> Repo.preload([:ingredients])
    |> IO.inspect()
    |> cast(attrs, [:name, :steps, :user_id])
    |> maybe_put_assoc(attrs)
    |> validate_required([:name, :steps, :user_id, :ingredients])
  end

  defp maybe_put_assoc(changeset, %{"ingredients" => ingredients}) do
    put_assoc(changeset, :ingredients, ingredients)
  end

  defp maybe_put_assoc(changeset, _), do: changeset
end
