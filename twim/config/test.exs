use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twim, TwimWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :twim, Twim.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "twim_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
