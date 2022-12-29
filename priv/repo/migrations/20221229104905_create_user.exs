defmodule WsChat.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table("users") do
      add :external_id, :uuid, null: false
      add :email, :text, null: false
      add :password_hash, :text, null: false

      timestamps()
    end

    create unique_index("users", [:external_id])
    create unique_index("users", [:email])
  end
end
