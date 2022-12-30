defmodule AuthTest do
  use ExUnit.Case
  alias WsChat.Core.Auth
  alias WsChat.Datasource.User

  doctest WsChat.Core.Auth

  setup_all do
    WsChat.Repo.insert!(%User{
      email: "test@email.com",
      password_hash: Bcrypt.hash_pwd_salt("test")
    })

    on_exit(fn ->
      WsChat.Repo.delete_all(User)
    end)

    :ok
  end

  test "succesful login" do
    assert {:ok, _} = Auth.login(%{email: "test@email.com", password: "test"})
  end

  test "invalid password" do
    assert {:error, :invalid_password} =
             Auth.login(%{email: "test@email.com", password: "wrong_password"})
  end

  test "email not found" do
    assert {:error, :not_found} =
             Auth.login(%{email: "not.valid@email.com", password: "wrong_password"})
  end
end
