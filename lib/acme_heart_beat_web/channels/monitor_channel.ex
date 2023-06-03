defmodule AcmeHeartBeatWeb.MonitorChannel do
  use AcmeHeartBeatWeb, :channel
  alias AcmeHeartBeat.Monitor

  @impl true
  def join("monitor:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (monitor:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("heart_beat", _payload, socket) do
    {:ok, heart_beat} = Monitor.get_current_value()
    {:reply, {:ok, %{heart_beat: heart_beat}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
