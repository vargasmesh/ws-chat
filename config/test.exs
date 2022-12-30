import Config

config :bcrypt_elixir, log_rounds: 4

config :ws_chat, WsChat.Repo,
  database: "db/database.test.sqlite",
  pool: Ecto.Adapters.SQL.Sandbox

config :joken,
  default_signer: "test"
