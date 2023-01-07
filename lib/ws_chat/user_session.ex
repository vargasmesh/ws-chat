defmodule WsChat.UserSession do
  use GenServer, restart: :temporary

  def init(%{user_id: user_id, ws_pid: ws_pid}) do
    {:ok, %{user_id: user_id, ws_pid: ws_pid}}
  end

  def start_link(%{user_id: user_id, ws_pid: ws_pid}) do
    GenServer.start_link(__MODULE__, %{user_id: user_id, ws_pid: ws_pid})
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  def handle_cast({:push}, state) do
    send(state.ws_pid, {:push, "Hello World from User Session!"})
    {:noreply, state}
  end
end
