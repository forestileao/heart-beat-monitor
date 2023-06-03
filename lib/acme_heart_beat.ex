defmodule AcmeHeartBeat do
  @moduledoc """
  AcmeHeartBeat keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate get_current_heartbeat, to: AcmeHeartBeat.Monitor, as: :get_current_value

  defdelegate get_heartbeat_by_range(from, to), to: AcmeHeartBeat.Monitor, as: :get_by_range
end
