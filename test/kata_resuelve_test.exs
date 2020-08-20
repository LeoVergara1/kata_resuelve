defmodule KataResuelveTest do
  use ExUnit.Case
  doctest KataResuelve

  test "get map from json file" do
    path = './jugadores.json'
    map_from_json = KataResuelve.parser_map_from_json_file(path)
    assert List.first(map_from_json["jugadores"]) == %{"bono" => 25000, "equipo" => "rojo", "goles" => 10, "nivel" => "C", "nombre" => "Juan Perez", "sueldo" => 50000, "sueldo_completo" => nil}
  end
end
