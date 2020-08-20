defmodule KataResuelveTest do
  use ExUnit.Case
  doctest KataResuelve

  test "get map from json file" do
    path = './jugadores.json'
    assert KataResuelve.parser_map_from_json_file(path) == %{}
  end
end
