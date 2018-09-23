defmodule ShoppingList.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipe) do
      add :name, :string
      add :steps, :text
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:recipe, [:user_id])
  end
end
