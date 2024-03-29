# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :shortlab,
  ecto_repos: [Shortlab.Repo]

# Configures the endpoint
config :shortlab, ShortlabWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ShortlabWeb.ErrorHTML, json: ShortlabWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Shortlab.PubSub,
  live_view: [signing_salt: "Xw6pXe1e"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :shortlab, Shortlab.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Rollbax config
config :rollbax,
  config_callback: {Shortlab.Config, :rollbar_envs},
  enabled: config_env() == :prod,
  enable_crash_reports: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :shortlab, Shortlab.Guardian,
  issuer: "shortlab",
  secret_key: System.fetch_env("GUARDIAN_SECRET_KEY")

# acho que tem que mudar isso aqui pra fazer igual em baixo ou fazer igual à wowlet

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
