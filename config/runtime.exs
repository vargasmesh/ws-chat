import Config

config :ws_chat,
  server_port:
    System.get_env("SERVER_PORT", "8080")
    |> String.to_integer()

config :joken,
  default_signer: System.get_env("JWT_SECRET")
