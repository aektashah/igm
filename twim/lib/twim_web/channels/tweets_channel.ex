defmodule TwimWeb.TweetsChannel do
  use TwimWeb, :channel
  use Agent
  alias TwimWeb.TweetController

  def join("tweets:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}# = Agent.start_link(fn -> nil end)
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("start_stream", payload, socket) do
    	#pid = spawn(fn ->
	
		stream = ExTwitter.stream_filter(locations: ['-180,-90,180,90'])
		|> Stream.filter(fn t -> t.geo != nil end)
		|> Stream.map(fn t -> TweetController.get_tweet_data(t) end)

		for t <- stream do
			broadcast socket, "new_tweet", t
		end
	#end)
	#Agent.update(socket, fn -> pid end)
	{:reply, {:ok, payload}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("change_loc", %{"lat" => lat, "lng" => lng}, socket) do
	# Agent.get(socket, fn -> pid end)
	
	{:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
