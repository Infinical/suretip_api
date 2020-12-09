# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :suretips_api,
  ecto_repos: [SuretipsApi.Repo]

# Configures the endpoint
config :suretips_api, SuretipsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cw65NPCsw9nHtkZoPoTOhGQ+wKVG2vy9oWULTOADyP/v8hc2rcVlUSVXz1TcMTDI",
  render_errors: [view: SuretipsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SuretipsApi.PubSub,
  live_view: [signing_salt: "MVdbYolM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
