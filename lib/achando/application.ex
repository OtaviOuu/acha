defmodule Achando.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AchandoWeb.Telemetry,
      Achando.Repo,
      {DNSCluster, query: Application.get_env(:achando, :dns_cluster_query) || :ignore},
      {Oban, Application.fetch_env!(:achando, Oban)},
      {Phoenix.PubSub, name: Achando.PubSub},
      # Start a worker by calling: Achando.Worker.start_link(arg)
      # {Achando.Worker, arg},
      # Start to serve requests, typically the last entry
      AchandoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Achando.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AchandoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
