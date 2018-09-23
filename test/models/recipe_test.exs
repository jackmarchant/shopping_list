defmodule ShoppingList.RecipeTest do
  use ShoppingList.ModelCase

  alias ShoppingList.Recipe

  @valid_attrs %{name: "some name", steps: "some steps"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
