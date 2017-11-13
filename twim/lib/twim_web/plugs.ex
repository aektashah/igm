defmodule Twim.Plugs do
  import Plug.Conn
  require Logger

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Twim.Accounts.get_user_by_user_id(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

end
