defmodule WsChat.Web.Websocket do
  @behaviour :cowboy_websocket
  require Logger

  def init(req, state) do
    {:cowboy_websocket, req, state}
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, message}, state) do
    Logger.debug("Received: #{message}")
    {:reply, {:text, "Hello World!"}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end
end
