defmodule CreditEngine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topology = [
      mnesia_multi_nodes: [
        strategy: Cluster.Strategy.Epmd,
        config: [hosts: [:bar@localhost, :baz@localhost]]
      ]
    ]

    hosts = [:bar@localhost, :baz@localhost]

    children = [
      {NodeJS.Supervisor, [path: LiveSvelte.SSR.NodeJS.server_path(), pool_size: 4]},
      # Start the Telemetry supervisor
      CreditEngineWeb.Telemetry,
      # Start the Ecto repository
      # CreditEngine.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CreditEngine.PubSub},
      # Start Finch
      {Finch, name: CreditEngine.Finch},
      # Start the Endpoint (http/https)
      CreditEngineWeb.Endpoint,
      {Cluster.Supervisor, [topology, [name: CreditEngine.ClusterSupervisor]]},
      {Mnesiac.Supervisor, [hosts, [name: CreditEngine.MnesiacSupervisor]]}
      # Start a worker by calling: CreditEngine.Worker.start_link(arg)
      # {CreditEngine.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CreditEngine.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CreditEngineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
