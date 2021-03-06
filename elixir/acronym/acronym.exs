defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r"(?=[[:upper:]])|\s")
    |> Enum.map(fn string ->
      string
      |> String.first
      |> String.upcase
    end)
    |> List.to_string
  end
end
