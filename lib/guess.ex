defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play Guess the Number")

    IO.gets("Pick a difficulty level: (1) Easy, (2) Medium, (3) Hard: ")
    |> Integer.parse()
    |> parse_input()
    |> get_range()
    |> IO.inspect()
  end

  def parse_input(:error) do
    IO.puts("\nInvalid Input!!!\n")
    run()
  end

  def parse_input({num, _}), do: num

  def get_range(level) do
    case level do
      1 ->
        1..10

      2 ->
        1..100

      3 ->
        1..1000

      _ ->
        IO.puts("\nInvalid level!!!\n")
        run()
    end
  end
end
