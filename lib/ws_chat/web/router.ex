defmodule WsChat.Web.Router do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello World!\n")
  end

  forward("/auth",
    to: WsChat.Web.Router.Auth,
    assigns: %{auth_mod: WsChat.Core.Auth}
  )

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
