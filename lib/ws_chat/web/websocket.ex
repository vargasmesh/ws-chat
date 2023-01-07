defmodule WsChat.Web.Websocket do
  alias WsChat.UserSupervisor
  @behaviour :cowboy_websocket
  require Logger

  def init(req, _state) do
    {:ok, user_session} = UserSupervisor.start_user_session("teste", req.pid)
    state = %{user_id: "teste", pid: req.pid, user_session: user_session}
    {:cowboy_websocket, req, state}
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, message}, state) do
    Logger.debug("Received: #{message}")
    GenServer.cast(state.user_session, {:push})
    {:ok, state}
  end

  def websocket_info({:push, message}, state) do
    {:reply, {:text, message}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end

  def terminate(_reason, _req, %{user_session: user_session}) do
    # DynamicSupervisor.terminate_child(UserSupervisor, user_session)
    GenServer.cast(user_session, :stop)
  end
end
