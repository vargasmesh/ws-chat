import Config

config :ws_chat,
  ecto_repos: [WsChat.Repo]

config :ws_chat, WsChat.Repo, database: "db/database.sqlite"

config :bcrypt_elixir, log_rounds: 13

config :ws_chat,
  user_repository: WsChat.Datasource.UserRepository

import_config "#{config_env()}.exs"
