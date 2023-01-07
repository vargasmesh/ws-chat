defmodule WsChat.UserSupervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_user_session(user_id, ws_pid) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {WsChat.UserSession, %{user_id: user_id, ws_pid: ws_pid}}
    )
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
