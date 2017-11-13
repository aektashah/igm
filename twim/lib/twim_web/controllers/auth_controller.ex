defmodule TwimWeb.AuthController do
	use TwimWeb, :controller
	require Logger
	alias Twim.Accounts

	def oauth_request_token do
		response = post_oauth_request("https://api.twitter.com/oauth/request_token", [])
		[get_val_resp(response, "oauth_token"), get_val_resp(response, "oauth_token_secret"), true]
	end

	def oauth_access_token(conn, oauth_token, oauth_verifier) do
		response = post_oauth_request("https://api.twitter.com/oauth/access_token", 
			[{"oauth_token", oauth_token}, {"oauth_verifier", oauth_verifier}])
		user = %{screen_name: get_val_resp(response, "screen_name"), oauth_token: get_val_resp(response, "oauth_token"),
			oauth_token_secret: get_val_resp(response, "oauth_token_secret"), user_id: get_val_resp(response, "user_id")}
		Accounts.create_user(user)
		String.to_integer(user.user_id)
	end

	defp post_oauth_request(url, postargs) do
		creds = OAuther.credentials(consumer_key: System.get_env("CONSUMER_KEY"), consumer_secret: System.get_env("CONSUMER_SECRET"), token: System.get_env("TOKEN"), token_secret: System.get_env("TOKEN_SECRET"))
		params = OAuther.sign("post", url, postargs, creds)
		{header, req_params} = OAuther.header(params)
		{:ok, code, header, ref} = :hackney.request('post', url, [header], {:form, req_params})
		{:ok, body} = :hackney.body(ref)
		decode_response(body)
	end

	defp decode_response(response) do
		key_val = String.split(response, "&")
		|> Enum.map(fn(kv) -> String.split(kv, "=") end)
	end

	def get_val_resp(response, key) do
		Enum.filter(response, fn(kv) -> Enum.at(kv, 0) == key end)
		|> Enum.at(0)
		|> Enum.at(1)
	end
end
