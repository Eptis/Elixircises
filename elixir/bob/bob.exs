defmodule Bob do
  import String

  def hey(input) do
    cond do
      questioning?(input)    -> "Sure."
      saying_nothing?(input) -> "Fine. Be that way!"
      yelling?(input)        -> "Whoa, chill out!"
      true                   -> "Whatever."
    end
  end

  defp questioning?(input), do: String.last(input) === "?"
  defp saying_nothing?(input), do: String.length(trim(input)) == 0
  defp yelling?(input), do: input =~ ~r/\b[A-Z]+\b/
end
