defmodule Test do
  @moduledoc """
  Documentation for `Test`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Test.hello()
      :world

  """
  def hello do
    :world
  end

  def swap({a,b}), do: {b,a}

  def check_same(a,a), do: true
  def check_same(_,_), do: false

end
