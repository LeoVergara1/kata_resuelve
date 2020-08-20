defmodule KataResuelve do
  @moduledoc """
  Documentation for `KataResuelve`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> path = './file.json'
      iex> KataResuelve.parser_map_from_json_file(path)
      %{}

  """
  def parser_map_from_json_file(path) do
    case File.read(path) do
      {:ok, file} -> IO.inspect file
      {:error, _} -> IO.puts "Error to read file"
    end
    %{}
  end
end
