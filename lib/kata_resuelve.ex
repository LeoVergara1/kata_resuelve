defmodule KataResuelve do
  @moduledoc """
  Documentation for `KataResuelve`.
  """
  @goals_by_nivel %{"A" => 5, "B" => 10, "C" => 15, "Cuauh" => 20}

  def parser_map_from_json_file(path) do
    case File.read(path) do
      {:ok, file} ->
        Jason.decode!(file)
      {:error, _} -> IO.puts "Error to read file"
    end
  end

  def calculate_percentage_by_team(list_players) do
    teams = Enum.group_by(list_players, fn (x) -> x["equipo"] end)
    for {key, value} <- teams, into: %{} do
      goal_players_by_team = Enum.map(value, fn(x) -> x["goles"] end)
      goal_require_by_team = Enum.map(value, fn(x) -> @goals_by_nivel[x["nivel"]] end)
      percentage = Enum.sum(goal_players_by_team) / Enum.sum(goal_require_by_team) * 100
      percentage = if percentage > 100, do: 100, else: percentage
      {key, percentage}
    end
  end

  def calculate_total_salary(percentage_player, percentage_team, salary, bonus) do
    bonus_neto = (((percentage_player + percentage_team)/2) / 100) * bonus
    IO.inspect bonus
    salary + bonus_neto
  end
end
