defmodule PusherProto.Supervisor do
  use Supervisor.Behaviour

  def start_link, do: :supervisor.start_link(__MODULE__, [])

  def init([]) do
    {:ok, pools} = :application.get_env(:pools)
    pool_specs = :lists.map(fn({name, size_args, worker_args}) ->
                                pool_args = [{:name, {:local, name}},
                                             {:worker_module, :python}] ++ size_args
                                :poolboy.child_spec(name, pool_args, worker_args)
                            end, pools)
    supervise(pool_specs, strategy: :one_for_one)
  end
end
