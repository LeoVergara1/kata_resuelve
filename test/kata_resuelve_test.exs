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
    assert KataResuelve.calculate_percentage_by_team(player) == %{"azul" => 70.0, "rojo" => 146.66666666666666} ## Duda!!! Que pasa si el equipo anota más goles de los requeridos!! Se toma como extra?
  end

  test "calculate total salary" do
    
  end
end
