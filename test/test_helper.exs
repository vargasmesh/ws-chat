ExUnit.start()

WsChat.Repo.start_link()

Application.put_env(:joken, :default_signer, "test")
