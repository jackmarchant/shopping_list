defmodule ShoppingList.Accounts.AuthenticateUser do
  alias ShoppingList.Accounts

  def execute(email, password) do
    email
    |> Accounts.get_user_by_email()
    |> validate_password(password)
  end

  # if we don't find a user
  def validate_password(nil, _), do: invalid_credentials()

  # if the password is blank
  def validate_password(_, nil), do: invalid_credentials()

  # check password against password hash
  def validate_password(user, password) do
    password
    |> Comeonin.Bcrypt.checkpw(user.password_hash)
    |> case do
      false -> invalid_credentials()
      true -> {:ok, user}
    end
  end

  def invalid_credentials, do: {:error, :invalid_credentials}
end
