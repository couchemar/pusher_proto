defmodule PusherProto.REST.API do
  def init(_transport, _req, []), do: {:upgrade, :protocol, :cowboy_rest}
  def allowed_methods(req, state), do: {["POST"], req, state}
  def content_types_accepted(req, state) do
    {[{{"application", "json", :"*"}, :from_json}], req, state}
  end

  def from_json(req, state) do
    {:ok, body, req} = :cowboy_req.body(req)
    body = JSEX.decode! body
    email = ListDict.get body, "email"
    center_id = ListDict.get body, "center_id"
    obj_number = ListDict.get body, "object_number"

    _pid = spawn(PusherProto.Exec, :push, [email, center_id, obj_number])
    {true, req, state}
  end

end