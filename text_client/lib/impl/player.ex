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
    IO.puts("Congratulations. You won!")
  end

  def interact({game, _tally = %{game_state: :lost}}) do
    IO.puts("Ya lost, mate. Try reading a dictionary. Word was: #{game.letters |> Enum.join()}")
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
    "Guess the word if ya can. Here be a clue, it be #{tally.letters |> length} letters in length."
  end

  def feedback_for(%{game_state: :good_guess}), do: "Lucky guess."
  def feedback_for(%{game_state: :bad_guess}), do: "WRONG, HAHAHA."
  def feedback_for(%{game_state: :already_used}), do: "Ya already used it, FOOL."
  # :initializing | :won | :lost | :good_guess | :bad_guess | :already_used

  def current_word(tally) do
    [
      "| Word so far: ",
      tally.letters |> Enum.join(" "),
      " |  guesses left: ",
      tally.turns_left |> to_string,
      " |  used so far: ",
      tally.used |> Enum.join(",")
    ]
  end

  def get_guess() do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end

end
