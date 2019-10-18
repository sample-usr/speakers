defmodule SpeakersTest do
  use ExUnit.Case
  doctest Speakers

  test "greets the world" do
    assert Speakers.hello() == :world
  end
end
