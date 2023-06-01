defmodule AcmeHeartBeatWeb.MonitorController do
  use AcmeHeartBeatWeb, :controller

  def index(conn, _params) do
    {:ok, heart_beat} = AcmeHeartBeat.get_heartbeat_monitor_value()

    conn
    |> put_status(:ok)
    |> json(%{ heart_beat: heart_beat })
  end
end
