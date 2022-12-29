defmodule WsChat.Db.User do
  use Ecto.Schema

  schema "users" do
    field(:email, :string)
    field(:external_id, Ecto.UUID, autogenerate: true)
    field(:password_hash, :string)
    timestamps()
  end
end
