defmodule WsChat.Datasource.UserRepository do
  @behaviour WsChat.Core.UserRepository
  @type credentials :: %{email: String.t(), password: String.t()}
  @type user :: %{id: String.t(), external_id: String.t(), email: String.t()}

  import Ecto.Query

  alias WsChat.Repo
  alias WsChat.Datasource.User

  @spec is_email_available?(String.t()) :: boolean
  def is_email_available?(email) do
    query =
      from u in User,
        where: u.email == ^email

    !Repo.exists?(query)
  end

  @spec create(credentials) ::
          {:ok, user()}
          | {:error, :could_not_create}
  def create(%{email: email, password: password}) do
    user = User.changeset(%User{}, %{email: email, password_hash: password})

    case Repo.insert(user) do
      {:ok, user} -> {:ok, %{id: user.id, external_id: user.external_id, email: user.email}}
      {:error, _} -> {:error, :could_not_create}
    end
  end
end
