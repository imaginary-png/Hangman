defmodule TextClient.Impl.Player do

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  #########################################################

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{ game_state: :won}} ) do
    Io.puts "Congratulations. You won!"
  end

  def interact({_game, tally = %{ game_state: :lost}} ) do
    IO.puts "Ya lost, mate. Try reading a dictionary. Word was: #{tally.letters |> Enum.join}"
  end

  def interact({game, tally}) do
    IO.puts feedback_for(tally)
    # feedback
    # display current word
    # get next guess
    # make move

  end

  # idk why I made it slightly piratey
  def feedback_for(tally = %{ game_state: :initializing }) do
    "Guess the word if ya can. Here be a clue, it be #{tally.letters |> length} letters in length."
  end

  def feedback_for(%{ game_state: :good_guess}), do: "Lucky guess."
  def feedback_for(%{ game_state: :bad_guess}), do: "WRONG, HAHAHA."
  def feedback_for(%{ game_state: :already_useds}), do: "Ya already used it, FOOL."
#:initializing | :won | :lost | :good_guess | :bad_guess | :already_used

#########################################################

end
