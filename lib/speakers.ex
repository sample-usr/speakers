defmodule Speakers do
  @moduledoc """
  Handles playing of remote audio streams through speakers.

  Whichever device is set as the default output, is selected for audio.
  """

  alias Speakers.Player

  defdelegate add_to_queue(url), to: Player
  defdelegate pause, to: Player
  defdelegate resume, to: Player
  defdelegate get_queue_len, to: Player
  defdelegate get_volume, to: Player
  defdelegate set_volume(new_volume), to: Player

  # def play_file() do
  #   Player.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")
  # end
end
