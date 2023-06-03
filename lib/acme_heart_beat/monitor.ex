defmodule AcmeHeartBeat.Monitor do
  @pi :math.pi()

  @spec get_current_value :: {:ok, float}
  def get_current_value do
    milliseconds = :os.system_time(:millisecond)

    {:ok, calc_by_time(milliseconds)}
  end

  def get_by_range(from, to) when to >= from do
    heart_beats = from..to
    |> Enum.map(&(calc_by_time(&1)))

    {:ok, heart_beats}
  end

  def get_by_range(_from, _to),
    do: {:error, "'to' param must be greater or equal to 'from' parameter."}

  def calc_by_time(time) do
    -0.06366 +
    0.12613 * :math.cos(@pi * time/500) +
    0.12258 * :math.cos(@pi * time/250) +
    0.01593 * :math.sin(@pi * time/500) +
    0.03147 * :math.sin(@pi * time/250)
  end
end
