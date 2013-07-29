defmodule PusherProto.Exec do

  def push(email, center_id, obj_number) do
    WebGate.start
    response = WebGate.get "object_managers.get_object_info?center_id=#{center_id}&object_number=#{obj_number}"
    body = response.body
    IO.inspect body
    IO.puts "PUSH!"
    :poolboy.transaction(:python_pool,
                         fn(pid) ->
                             :python.call pid, :pusher, :push, [email]
                         end)
  end

end