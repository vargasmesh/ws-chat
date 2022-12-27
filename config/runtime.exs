import Config

config :ws_chat,
  server_port:
    System.get_env("SERVER_PORT", "8080")
    |> String.to_integer()
