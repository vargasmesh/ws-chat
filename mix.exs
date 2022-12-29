defmodule WsChat.MixProject do
  use Mix.Project

  def project do
    [
      app: :ws_chat,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WsChat.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:ecto_sqlite3, "~> 0.9.1"},
      {:bcrypt_elixir, "~> 3.0"}
    ]
  end
end
