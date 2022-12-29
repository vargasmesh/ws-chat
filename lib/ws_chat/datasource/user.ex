defmodule WsChat.Datasource.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :external_id, Ecto.UUID, autogenerate: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password_hash])
    |> unique_constraint(:email)
  end
end
