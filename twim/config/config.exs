# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :twim,
  ecto_repos: [Twim.Repo]

# Configures the endpoint
config :twim, TwimWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+KwIgrea4BMMt9A/20K3/43LsMTAJ4lIPnlrgltHdIJueNfLwbG4IHBlXwytWf7A",
  render_errors: [view: TwimWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Twim.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures ExTwitter
config :extwitter, :oauth, [
   consumer_key: System.get_env("CONSUMER_KEY"),
   consumer_secret: System.get_env("CONSUMER_SECRET"),
   access_token: System.get_env("TOKEN"),
   access_token_secret: System.get_env("TOKEN_SECRET")
]

# Configures Porcelain to suppress goon warning
config :porcelain, driver: Porcelain.Driver.Basic

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
