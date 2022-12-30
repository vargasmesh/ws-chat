defmodule WsChat.Core.Auth do
  alias WsChat.Core.Token

  @type credentials :: %{email: String.t(), password: String.t()}

  def signup(%{email: email, password: password}, hash \\ &Bcrypt.hash_pwd_salt/1) do
    unless user_repository().is_email_available?(email) do
      {:error, :email_already_registered}
    else
      user_repository().create(%{email: email, password: hash.(password)})
    end
  end

  @spec login(%{:email => String.t(), :password => String.t(), optional(any) => any}, any) ::
          {:error, :invalid_password | :not_found} | {:ok, binary}
  def login(%{email: email, password: password}, compare_hash \\ &Bcrypt.verify_pass/2) do
    case user_repository().get_by_email(email) do
      nil ->
        {:error, :not_found}

      user ->
        unless compare_hash.(password, user.password) do
          {:error, :invalid_password}
        else
          {:ok, Token.generate_and_sign!(%{"user_id" => user.external_id, "email" => user.email})}
        end
    end
  end

  @spec user_repository() :: WsChat.Core.UserRepository
  def user_repository do
    Application.get_env(:ws_chat, :user_repository)
  end
end
