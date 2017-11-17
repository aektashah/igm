defmodule TwimWeb.PageController do
	use TwimWeb, :controller
	require Logger
	alias TwimWeb.AuthController
	alias TwimWeb.TweetController

	def index(conn, _params) do
		render conn, "index.html"
	end
end
