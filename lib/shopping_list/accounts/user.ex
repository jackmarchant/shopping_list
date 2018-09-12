defmodule ShoppingList.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "user" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> put_password_hash()
    |> validate_required([:name, :email, :password_hash])
  end

  defp put_password_hash(%Ecto.Changeset{
        valid?: true,
        changes: %{password: pass}
      } = changeset),
    do: put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

  defp put_password_hash(changeset), do: changeset
end
