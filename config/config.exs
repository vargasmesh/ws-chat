import Config

config :ws_chat,
  ecto_repos: [WsChat.Repo]

config :ws_chat, WsChat.Repo, database: "db/database.sqlite"
