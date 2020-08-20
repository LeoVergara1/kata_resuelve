defmodule KataResuelve do
  @moduledoc """
  Documentation for `KataResuelve`.
  """

  def parser_map_from_json_file(path) do
    case File.read(path) do
      {:ok, file} ->
        Jason.decode!(file)
      {:error, _} -> IO.puts "Error to read file"
    end
  end
end
