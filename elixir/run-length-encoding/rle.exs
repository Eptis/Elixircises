defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t

  def encode(""), do: ""
  def encode(string) do
    case Regex.run(~r/\s/, string) do
      nil -> _encode(String.graphemes(string))
      _ -> string
    end
  end

  defp _encode([first_char|remaining]) do
    _encode(remaining, first_char, 1, "")
  end

  defp _encode([next_char|remaining], current_char, count, acc) do
    cond do
      current_char == next_char ->
        _encode(remaining, next_char, count + 1, acc)
      true ->
        _encode(remaining, next_char, 1, merge_char_count(acc, current_char, count))
    end
  end
  defp _encode([], current_char, count, acc), do: merge_char_count(acc, current_char, count)

  defp merge_char_count(acc, char, 1), do: "#{acc}#{char}"
  defp merge_char_count(acc, char, count), do: "#{acc}#{count}#{char}"


  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    case Regex.run(~r/\s/, string) do
      nil -> _decode(string)
      _ -> string
    end
  end

  defp _decode(string) do
    String.split(string, ~r/([A-Z])/, include_captures: true)
    |> Enum.chunk(2)
    |> Enum.reduce("", fn ([count|char], acc) ->
      acc <> _decode_char(count, char)
    end)
  end

  defp _decode_char("", [char]), do: char
  defp _decode_char(count, [char]) do
    String.duplicate(char, String.to_integer(count))
  end
end
