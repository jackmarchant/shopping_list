defmodule ShoppingList.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingList.Accounts.User

  schema "recipe" do
    field :name, :string
    field :steps, :string

    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :steps, :user_id])
    |> validate_required([:name, :steps, :user_id])
  end
end
