defmodule Shortlab.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ShortlabWeb.Telemetry,
      # Start the Ecto repository
      Shortlab.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Shortlab.PubSub},
      # Start Finch
      {Finch, name: Shortlab.Finch},
      # Start the Endpoint (http/https)
      ShortlabWeb.Endpoint
      # Start a worker by calling: Shortlab.Worker.start_link(arg)
      # {Shortlab.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shortlab.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShortlabWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
