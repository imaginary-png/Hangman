defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  #########################################################

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts(
      IO.ANSI.blink_slow() <>
        IO.ANSI.green_background() <>
        IO.ANSI.blue() <>
        "Congratulations. You won!" <>
        IO.ANSI.reset()
    )
  end

  def interact({game, _tally = %{game_state: :lost}}) do
    IO.puts(
      IO.ANSI.red_background <>
      IO.ANSI.bright() <>
      IO.ANSI.black() <>
      "Ya lost, mate. Try reading a dictionary." <>
      IO.ANSI.reset() <>
      "  The word was: " <>
      IO.ANSI.cyan() <>
      "#{game.letters |> Enum.join()}" <>
      IO.ANSI.reset()
      )
  end

  def interact({game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    Hangman.make_move(game, get_guess())
    |> interact()
  end

  #########################################################

  # idk why I made it slightly piratey
  def feedback_for(tally = %{game_state: :initializing}) do
    "Guess the word if ya can. Here be a clue, cit be " <>
      IO.ANSI.green() <>
      "#{tally.letters |> length} letters in length." <>
      IO.ANSI.reset()
  end

  def feedback_for(%{game_state: :good_guess}),
    do: IO.ANSI.green() <> "Lucky guess." <> IO.ANSI.reset()

  def feedback_for(%{game_state: :bad_guess}),
    do: IO.ANSI.red() <> "WRONG, HAHAHA." <> IO.ANSI.reset()

  def feedback_for(%{game_state: :already_used}),
    do: IO.ANSI.yellow() <> "Ya already used it, FOOL." <> IO.ANSI.reset()

  # :initializing | :won | :lost | :good_guess | :bad_guess | :already_used

  def current_word(tally) do
    [
      "| Word so far: ",
      tally.letters |> Enum.join(" "),
      IO.ANSI.green() <> " |  guesses left: ",
      IO.ANSI.blue() <> (tally.turns_left |> to_string),
      IO.ANSI.green() <> " |  used so far: ",
      IO.ANSI.yellow() <> (tally.used |> Enum.join(",")) <> IO.ANSI.reset()
    ]
  end

  def get_guess() do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
