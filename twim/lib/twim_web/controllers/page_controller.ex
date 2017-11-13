defmodule TwimWeb.PageController do
	use TwimWeb, :controller
	require Logger
	alias TwimWeb.AuthController

	def index(conn, %{"oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier}) do
		user = AuthController.oauth_access_token(conn, oauth_token, oauth_verifier)
		conn
		|> put_session(:user_id, user)
		|> redirect(to: "/")
	end

	def index(conn, _params) do
		tokens = AuthController.oauth_request_token
		render conn, "index.html", oauth_token: Enum.at(tokens, 0), oauth_token_secret: Enum.at(tokens, 1), oauth_callback: Enum.at(tokens, 2)
	end
end
