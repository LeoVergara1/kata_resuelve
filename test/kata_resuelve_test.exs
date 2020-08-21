defmodule KataResuelveTest do
  use ExUnit.Case
  doctest KataResuelve

  test "get map from json file" do
    path = './jugadores.json'
    map_from_json = KataResuelve.parser_map_from_json_file(path)
    assert List.first(map_from_json["jugadores"]) == %{"bono" => 25000, "equipo" => "rojo", "goles" => 10, "nivel" => "C", "nombre" => "Juan Perez", "sueldo" => 50000, "sueldo_completo" => nil}
  end

  test "calculate percentage by team" do
    player = [
      %{
      "nombre" => "Juan",
      "nivel" => "A",
      "goles" => 6,
      "sueldo" => 50000,
      "bono" => 25000,
      "sueldo_completo" => nil,
      "equipo" => "rojo"
      },
      %{
      "nombre" => "Pedro",
      "nivel" => "B",
      "goles" => 7,
      "sueldo" => 60000,
      "bono" => 35000,
      "sueldo_completo" => nil,
      "equipo" => "azul"
      },
      %{
      "nombre" => "Martin",
      "nivel" => "B",
      "goles" => 16,
      "sueldo" => 40000,
      "bono" => 35000,
      "sueldo_completo" => nil,
      "equipo" => "rojo"
      },
    ]
    assert KataResuelve.calculate_percentage_by_team(player) == %{"azul" => 70.0, "rojo" => 100} ## Duda!!! Que pasa si el equipo anota más goles de los requeridos!! Se toma como extra?
  end

  test "calculate total salary" do
    salary = 50000.00
    percentage_player = 95
    percentage_team = 96
    bonus = 10000.00
    assert KataResuelve.calculate_total_salary(percentage_player, percentage_team, salary, bonus) == 59550.00
  end

  test "calculate all bonus by players in json" do
    juan = List.first(KataResuelve.calculate_all_bonus_by_players_json("./jugadores.json"))
    assert juan  == %{"equipo" => "rojo", "goles_minimos" => 15, "nombre" => "Juan Perez", "sueldo" => 50000, "sueldo_completo" => 67833.33, "bono" => 25000, "goles" => 10}
  end

  test "write json file from map" do
    map = KataResuelve.calculate_all_bonus_by_players_json("./jugadores.json")
    name_file = "jugadores_resuelve.json"
    assert KataResuelve.write_json_file_from_map(map, name_file) == :ok
  end
end
