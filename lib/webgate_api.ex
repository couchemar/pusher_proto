defmodule WebGate do
  use HTTPotion.Base

  defexception WGException, code: nil,
                            message: nil do
    def message(__MODULE__[code: code,
                           message: message]) do
      "(#{code}) #{message}"
    end
  end

  def process_url(url) do
    "http://localhost:8081/json/" <> url
  end

  def process_response_body(body) do
    body = JSEX.decode! to_binary(body)
    if ListDict.has_key? body, "exception" do
      exception = ListDict.get body, "exception"
      raise WGException, message: ListDict.get(exception, "message"),
                         code: ListDict.get(exception, "code")
    end
    body
  end

end