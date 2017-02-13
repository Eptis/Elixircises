defmodule Raindrops do
  import Enum
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    factors = map(Range.new(1, number), &_convert(&1, number))
    |> uniq
    |> sort
    |> Enum.filter(&(&1 == 3 || &1 == 5 || &1 == 7))

    case factors do
      [] -> raindrop(number)
      list -> raindrop(list)
    end
  end

  defp _convert(int, number) do
    number / int
  end

  def raindrop(3.0), do: "Pling"
  def raindrop(5.0), do: "Plang"
  def raindrop(7.0), do: "Plong"
  def raindrop(number) when is_number(number), do: Integer.to_string(number)
  def raindrop(list) when is_list(list) do
    list
    |> Enum.map(&(raindrop(&1)))
    |> List.to_string
  end
end
