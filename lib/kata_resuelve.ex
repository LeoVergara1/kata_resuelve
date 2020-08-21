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
    Float.round(salary + bonus_neto, 2)
  end

  def calculate_percentage_by_player(goals_player, level) do
    percentage = (goals_player / @goals_by_nivel[level]) * 100
    if percentage > 100, do: 100, else: percentage
  end

  def calculate_all_bonus_by_players_json(path) do
    list_players = parser_map_from_json_file(path)
    percentages_by_team = calculate_percentage_by_team(list_players["jugadores"])
    Enum.map(list_players["jugadores"], fn (player) ->
      percentage_player = calculate_percentage_by_player(player["goles"], player["nivel"])
      %{
        "nombre" => player["nombre"],
        "goles_minimos" => @goals_by_nivel[player["nivel"]],
        "sueldo" => player["sueldo"],
        "sueldo_completo" => calculate_total_salary(percentage_player, percentages_by_team[player["equipo"]], player["sueldo"], player["bono"]),
        "equipo" => player["equipo"]
       }
    end)
  end
end
