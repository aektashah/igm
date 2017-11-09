defmodule Twim.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twim.Accounts.User


  schema "user" do
    field :oauth_token, :string
    field :oauth_token_secret, :string
    field :screen_name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:screen_name, :user_id, :oauth_token, :oauth_token_secret])
    |> validate_required([:screen_name, :user_id, :oauth_token, :oauth_token_secret])
  end
end
