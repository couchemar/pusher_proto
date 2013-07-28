defmodule PusherProto.Mixfile do
  use Mix.Project

  def project do
    [ app: :pusher_proto,
      version: "0.0.1",
      elixir: "~> 0.10.1-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { PusherProto, [] },
     applications: [:ranch, :cowboy],
     env: [pools: [{:python_pool,
                    [size: 10, max_overflow: 20],
                    [python_path: 'priv/python']}]]]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:cowboy, github: "extend/cowboy"},
     {:erlport, github: "hdima/erlport"},
     {:poolboy, github: "devinus/poolboy"}]
  end
end
