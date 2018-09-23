defmodule ShoppingList.Recipe do
  use ShoppingList.Web, :model

  schema "recipe" do
    field :name, :string
    field :steps, :string
    belongs_to :user, ShoppingList.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :steps])
    |> validate_required([:name, :steps])
  end
end
