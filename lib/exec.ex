defmodule PusherProto.Exec do

  def push do
    IO.puts "PUSH!"
    :poolboy.transaction(:python_pool,
                         fn(pid) ->
                             :python.call pid, :pusher, :push, []
                         end)
  end

end