defmodule AcmeHeartBeat do
  @moduledoc """
  AcmeHeartBeat keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate get_heartbeat_monitor_value, to: AcmeHeartBeat.Monitor, as: :get_current_value
end
