defmodule ShoppingList.Repo do
  use Ecto.Repo, otp_app: :shopping_list

  @doc false
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
