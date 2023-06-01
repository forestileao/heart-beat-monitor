defmodule AcmeHeartBeat.Monitor do
  import DateTime, only: [utc_now: 0, to_unix: 1]

  @pi :math.pi()

  @spec get_current_value :: {:ok, float}
  def get_current_value do
    milliseconds = 1000 * (
      utc_now()
      |> to_unix()
    )

    {:ok, calc_by_time(milliseconds)}
  end

  defp calc_by_time(time) do
    -0.06366 +
    0.12613 * :math.cos(@pi * time/500) +
    0.12258 * :math.cos(@pi * time/250) +
    0.01593 * :math.sin(@pi * time/500) +
    0.03147 * :math.sin(@pi * time/250)
  end
end
