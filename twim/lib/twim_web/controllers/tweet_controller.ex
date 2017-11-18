defmodule TwimWeb.TweetController do
        use TwimWeb, :controller
	require Logger

	def search(conn, %{"lat" => lat, "long" => long}) do
	 	tweets = format_tweets(ExTwitter.request(:get, "1.1/search/tweets.json", [geocode: "#{lat},#{long},2mi"]))
		render(conn, "index.json", tweets: tweets)
	end
	
	def search(conn, _params) do
		render(conn, "index.json", tweets: [])
	end

	def format_tweets(data) do
		data.statuses
		|> Enum.filter(fn(t) -> t.geo != nil end)
		|> Enum.map(fn(t) -> get_tweet_data(t) end)
	end

	def get_tweet_data(tweet) do
		%{:geo => tweet.geo, 
			:id => tweet.id_str, 
			:text => tweet.text, 
			:screen_name => tweet.user.screen_name,
			:name => tweet.user.name,
			:lang => tweet.lang,
			:date => tweet.created_at}
	end
end
