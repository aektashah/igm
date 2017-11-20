defmodule TwimWeb.TweetsChannel do
  use TwimWeb, :channel
  require Logger
  alias TwimWeb.TweetController

  def join("tweets:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("start", payload, socket) do
	# reference: https://www.sitepoint.com/comparing-rails-exploring-websockets-in-phoenix
	stream = ExTwitter.stream_filter(locations: ['-180,-90,180,90'])
	|> Stream.filter(fn t -> t != :ok end) # fixes issue that stops stream
	|> Stream.filter(fn t -> t.geo != nil end)
	|> Stream.map(fn t -> TweetController.get_tweet_data(t) end)
	|> Enum.each(fn t -> broadcast socket, "tweet", t end)
	
	{:reply, {:ok, payload}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in(event, payload, socket) do
	{:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
