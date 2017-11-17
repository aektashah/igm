defmodule TwimWeb.SessionController do
	use TwimWeb, :controller
	require Logger

	def logout(conn, _params) do
		conn
		|> put_session(:user_id, nil)
		|> redirect(to: "/")
	end
end
