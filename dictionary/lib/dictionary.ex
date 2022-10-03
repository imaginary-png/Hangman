defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Dictionary.hello()
      :world

  """
  def hello do
    IO.puts "Hello World"
    :world
  end

  def word_list do
    words = File.read!("assets/words.txt")
    String.split(words, ~r/\n/, trim: true)
  end

  def random_word do
    Enum.random(word_list())
  end
end
