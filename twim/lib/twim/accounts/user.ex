defmodule Twim.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twim.Accounts.User


  schema "users" do
    field :token, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :token])
    |> validate_required([:username, :token])
  end
end
