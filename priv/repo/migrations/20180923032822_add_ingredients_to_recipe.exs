defmodule ShoppingList.Repo.Migrations.AddIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredient) do
      add(:name, :string, null: false)

      timestamps()
    end

    create table(:recipe_ingredient) do
      add(:quantity, :string)
      add(:recipe_id, references(:recipe, on_delete: :delete_all), null: false)
      add(:ingredient_id, references(:ingredient, on_delete: :delete_all), null: false)
    end
  end
end
