defmodule TwimWeb.TweetController do
        use TwimWeb, :controller
	require Logger

	def search(conn, %{"lat" => lat, "long" => long}) do
	 	tweets = format_tweets(ExTwitter.request(:get, "1.1/search/tweets.json", [geocode: "#{lat},#{long},1mi"]))
		render(conn, "index.json", tweets: tweets)
	end
	
	def search(conn, _params) do
		render(conn, "index.json", tweets: [])
	end

	def format_tweets(data) do
		data.statuses
		|> Enum.filter(fn(t) -> t.geo != nil end)
		|> Enum.map(fn(x) -> %{:geo => x.geo, :id => x.id, :text => x.text, :screen_name => x.user.screen_name} end)
	end

end
