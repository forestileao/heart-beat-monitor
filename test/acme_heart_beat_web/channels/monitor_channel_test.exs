defmodule AcmeHeartBeatWeb.MonitorChannelTest do
  use AcmeHeartBeatWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      AcmeHeartBeatWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(AcmeHeartBeatWeb.MonitorChannel, "monitor:lobby")

    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to monitor:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end

  test "get current heart beat", %{socket: socket} do
    {:ok, heart_beat} = AcmeHeartBeat.Monitor.get_current_value()

    ref = push(socket, "heart_beat")

    assert_reply ref, :ok, %{heart_beat: heart_beat}
  end
end
