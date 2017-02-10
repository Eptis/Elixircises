defmodule Words do
  import String
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
      |> downcase
      |> split(~r/[^[:alnum:]-]/u, trim: true)
      |> Enum.reduce(Map.new, fn (word, acc) ->
          Map.update(acc, word, 1, &(&1 + 1))
        end)
  end
end
