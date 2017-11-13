defmodule Twim.Accounts do
  import Ecto.Query, warn: false
  alias Twim.Repo

  alias Twim.Accounts.User

    def create_user(attrs \\ %{}) do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end
   
    def get_user_by_screen_name(screen_name) do
      Repo.get_by(User, screen_name: screen_name)    
    end

    def get_user_by_user_id(user_id) do
      Repo.get_by(User, user_id: user_id)
    end

    def update_user(%User{} = user, attrs) do 
      user
      |> User.changeset(attrs)
      |> Repo.update()
    end 

    def delete_user(%User{} = user) do
      Repo.delete(user)
    end



end
