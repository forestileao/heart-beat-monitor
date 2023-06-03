defmodule AcmeHeartBeatWeb.MonitorController do
  use AcmeHeartBeatWeb, :controller

  def index(conn, _params) do
    {:ok, heart_beat} = AcmeHeartBeat.get_current_heartbeat()

    conn
    |> put_status(:ok)
    |> json(%{ heart_beat: heart_beat, requested_at: DateTime.utc_now() })
  end

  def get_by_range(conn, %{from: from, to: to}) when is_integer(from) and is_integer(to) do
    response = AcmeHeartBeat.get_heartbeat_by_range(from, to)

    handle_range_response(conn, response)
  end

  defp handle_range_response(conn, {:ok, heart_beats}) do
    conn
    |> put_status(:ok)
    |> json(%{
      heart_beats: heart_beats,
      data_count: length(heart_beats),
      requested_at: DateTime.utc_now()
    })
  end
  defp handle_range_response(_conn, {:error, _} = error), do: error
end
