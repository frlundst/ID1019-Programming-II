defmodule LastTest do
  use ExUnit.Case
  doctest Last

  test "greets the world" do
    assert Last.hello() == :world
  end
end
