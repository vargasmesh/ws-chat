defmodule WsChat.Web.Router.Auth do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  post "/" do
    with %{"email" => email, "password" => password} <- conn.body_params do
      IO.puts("Email is #{email} and password is: #{password}")
      send_resp(conn, 200, "Success!")
    else
      _ -> send_resp(conn, 400, Jason.encode!(%{error: "invalid payload"}))
    end
  end
end
