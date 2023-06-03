defmodule AcmeHeartBeatWeb.MonitorController do
  use AcmeHeartBeatWeb, :controller

  action_fallback AcmeHeartBeatWeb.FallbackController

  def index(conn, _params) do
    {:ok, heart_beat} = AcmeHeartBeat.get_current_heartbeat()

    conn
    |> put_status(:ok)
    |> json(%{ heart_beat: heart_beat, requested_at: DateTime.utc_now() })
  end

  def get_by_range(conn, %{"from" => from, "to" => to}) do
    with {:ok, from_integer, to_integer} <- parse_range_params(from, to) do
      response = AcmeHeartBeat.get_heartbeat_by_range(from_integer, to_integer)

      handle_range_response(conn, response)
    end
  end

  defp parse_range_params(from, to) do
    parsed_from = Integer.parse(from)
    parsed_to = Integer.parse(to)
    case {parsed_from ,parsed_to} do
      {{from_integer, _}, {to_integer, _}} -> {:ok, from_integer, to_integer}
      _ -> {:error, "'from' and 'to' parameters must be integers."}
    end
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
