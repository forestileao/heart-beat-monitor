defmodule AcmeHeartBeatWeb.MonitorControllerTest do
  use AcmeHeartBeatWeb.ConnCase, async: true

  alias AcmeHeartBeat.Monitor

  describe "index/2" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "returns current heartbeat", %{conn: conn} do

      expected_heartbeat = AcmeHeartBeat.Monitor.get_current_value()

      response =
        conn
        |> get("/api/v1/monitor")
        |> json_response(:ok)

      assert %{"heart_beat" => expected_heartbeat} = response
    end
  end

  describe "get_by_range/2" do
    test "returns heart beats within the given range", %{conn: conn} do
      from = :os.system_time(:millisecond)
      to = from + 1000
      expected = Enum.map(from..to, &(Monitor.calc_by_time(&1)))

      response =
        conn
        |> get("/api/v1/monitor/range", %{"from" => from, "to" => to})
        |> json_response(:ok)

      assert response = %{
        heart_beats: expected,
        data_count: length(expected),
      }
    end

    test "handles error response", %{conn: conn} do
      from = :os.system_time(:millisecond)
      to = from - 1000
      expected = Enum.map(from..to, &(Monitor.calc_by_time(&1)))

      response =
        conn
        |> get("/api/v1/monitor/range", %{"from" => from, "to" => to})
        |> json_response(:bad_request)

      assert response = %{error: "'to' param must be greater or equal to 'from' parameter."}
    end
  end
end
