defmodule Twim.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :screen_name, :string
      add :user_id, :integer
      add :oauth_token, :string
      add :oauth_token_secret, :string

      timestamps()
    end

  end
end
