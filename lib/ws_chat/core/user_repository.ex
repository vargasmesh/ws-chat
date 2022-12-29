defmodule WsChat.Core.UserRepository do
  @callback is_email_available?(String.t()) :: boolean()
end
