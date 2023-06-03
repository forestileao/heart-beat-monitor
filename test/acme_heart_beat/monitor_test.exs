defmodule AcmeHeartBeat.MonitorTest do
  use ExUnit.Case

  alias AcmeHeartBeat.Monitor

  describe "get_current_value/0" do
    test "returns the current value" do
      expected = Monitor.calc_by_time(:os.system_time(:millisecond))
      assert {:ok, expected} == Monitor.get_current_value()
    end
  end

  describe "get_by_range/2" do
    test "returns heart beats within the given range" do
      from = :os.system_time(:millisecond)
      to = from + 1000
      expected = Enum.map(from..to, &(Monitor.calc_by_time(&1)))
      assert {:ok, expected} == Monitor.get_by_range(from, to)
    end

    test "returns error when 'to' is less than 'from'" do
      from = :os.system_time(:millisecond)
      to = from - 1000
      assert {:error, "'to' param must be greater or equal to 'from' parameter."} == Monitor.get_by_range(from, to)
    end
  end
end
