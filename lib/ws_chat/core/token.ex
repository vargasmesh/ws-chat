defmodule WsChat.Core.Token do
  use Joken.Config

  def get_signer do
    Joken.Signer.create("HS256", Application.get_env(:joken, :default_signer))
  end
end
