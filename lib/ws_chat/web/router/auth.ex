defmodule WsChat.Web.Router.Auth do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/login" do
    with %{"email" => email, "password" => password} <- conn.body_params,
         {:ok, token} <- conn.assigns.auth_mod.login(%{email: email, password: password}) do
      send_resp(conn, 200, Jason.encode!(%{token: token}))
    else
      {:error, _} ->
        send_resp(
          conn,
          400,
          Jason.encode!(%{error: "could not find a user with this combination"})
        )
    end
  end

  post "/signup" do
    with %{"email" => email, "password" => password} <- conn.body_params,
         {:ok, user} <- conn.assigns.auth_mod.signup(%{email: email, password: password}) do
      send_resp(conn, 200, Jason.encode!(%{id: user.external_id}))
    else
      {:error, :email_already_registered} ->
        send_resp(conn, 400, Jason.encode!(%{error: "this email has been taken"}))

      {:error, _} ->
        send_resp(conn, 400, Jason.encode!(%{error: "user could not be created"}))

      _ ->
        send_resp(conn, 400, Jason.encode!(%{error: "invalid payload"}))
    end
  end
end
