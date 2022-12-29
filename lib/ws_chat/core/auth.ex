defmodule WsChat.Core.Auth do
  @type credentials :: %{email: String.t(), password: String.t()}

  def signup(%{email: email, password: password}, hash \\ &Bcrypt.hash_pwd_salt/1) do
    unless user_repository().is_email_available?(email) do
      {:error, :email_already_registered}
    else
      user_repository().create(%{email: email, password: hash.(password)})
    end
  end

  @spec user_repository() :: WsChat.Core.UserRepository
  def user_repository do
    Application.get_env(:ws_chat, :user_repository)
  end
end
