defmodule PusherProto.Exec do

  def push(email) do
    IO.puts "PUSH!"
    :poolboy.transaction(:python_pool,
                         fn(pid) ->
                             :python.call pid, :pusher, :push, [email]
                         end)
  end

end