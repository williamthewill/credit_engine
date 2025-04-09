# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :credit_engine,
  ecto_repos: [CreditEngine.Repo]

# Configures the endpoint
config :credit_engine, CreditEngineWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: CreditEngineWeb.ErrorHTML, json: CreditEngineWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CreditEngine.PubSub,
  live_view: [signing_salt: "Sf5E4nhu"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :credit_engine, CreditEngine.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.17.11",
#   default: [
#     args:
#       ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mnesiac,
  stores: [CreditEngine.Stores.ChartData],
  # defaults to :ram_copies
  schema_type: :disc_copies,
  # milliseconds, default is 600_000
  table_load_timeout: 600_000

config :libcluster,
  topologies: [
    mnesia_multi_nodes: [
      strategy: Cluster.Strategy.Epmd,
      config: [hosts: [:bar@localhost, :baz@localhost]]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
