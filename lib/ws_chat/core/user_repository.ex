defmodule WsChat.Core.UserRepository do
  @type credentials :: %{email: String.t(), password: String.t()}
  @type user :: %{
          id: String.t(),
          external_id: String.t(),
          email: String.t(),
          password: String.t()
        }

  @callback is_email_available?(String.t()) :: boolean()
  @callback create(credentials) :: {:ok, user()} | {:error, :could_not_create}
  @callback get_by_email(String.t()) :: user()
end
