defmodule WsChat.Application do
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    port = Application.fetch_env!(:ws_chat, :server_port)

    children = [
      {Plug.Cowboy,
       scheme: :http, plug: WsChat.Web.Router, options: [port: port, dispatch: dispatch()]}
    ]

    Logger.info("Listening on: http://127.0.0.1:#{port}")

    opts = [strategy: :one_for_one, name: WsChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws", WsChat.Web.Websocket, []},
         {:_, Plug.Cowboy.Handler, {WsChat.Web.Router, []}}
       ]}
    ]
  end
end
