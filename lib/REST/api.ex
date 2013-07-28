defmodule PusherProto.REST.API do
  def init(_transport, _req, []), do: {:upgrade, :protocol, :cowboy_rest}
  def allowed_methods(req, state), do: {["POST"], req, state}
  def content_types_accepted(req, state), do: {[{{"application", "json", :"*"}, :from_json}], req, state}

  def from_json(req, state) do
    _pid = spawn(PusherProto.Exec, :push, [])
    {true, req, state}
  end

end