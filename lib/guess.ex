defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play Guess the Number")

    IO.gets("Pick a difficulty level: (1) Easy, (2) Medium, (3) Hard: ")
    |> parse_input()
    |> pickup_number()
    |> play()
    |> IO.inspect()
  end

  def play(picked_num) do
    IO.gets("I have my number. What's your guess? ")
    |> parse_input()
    |> guess(picked_num, 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess > picked_num do
    IO.gets("Too high. Guess again: ")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess < picked_num do
    IO.gets("Too low. Guess again: ")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(_usr_guess, picked_num, count) do
    IO.puts(
      "\n*************************\nYou got it #{count} guess! The number was #{picked_num}\n*************************\n"
    )
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def parse_input(:error) do
    IO.puts("\nInvalid Input!!!\n")
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

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
