defmodule PusherProto do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    {:ok, _} = :cowboy.start_http(:http, 100,
                                  [port: 9999],
                                  [env: [dispatch: compile_routes]])
    PusherProto.Supervisor.start_link
  end

  defp compile_routes do
    [
     {:_, [{"/api/push", PusherProto.REST.API, []}]}
    ] |> :cowboy_router.compile
  end

  def update_routes do
    :cowboy.set_env :http, :dispatch, compile_routes
  end
end
