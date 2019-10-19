defmodule Speakers do
  @moduledoc """
  Handles playing of remote audio streams through speakers.

  Whichever device is set as the default output, is selected for audio.
  """

  alias Speakers.Player

  @doc """
  Adds an audio stream URL to the queue. If the queue is empty it'll play it immediately

  ## Parameters

    - url: String that represents the URL of the audio stream

  ## Examples

      iex> Speakers.add_to_queue("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")
      {:ok}
  """
  defdelegate add_to_queue(url), to: Player

  @doc """
  Pauses the currently playing audio stream

  ## Examples

      iex> Speakers.pause()
      :ok
  """
  defdelegate pause, to: Player

  @doc """
  Resumes the currently playing audio stream

  ## Examples

      iex> Speakers.resume()
      :ok
  """
  defdelegate resume, to: Player

  @doc """
  Returns the number of audio streams in the queue

  ## Examples

      iex> Speakers.get_queue_len()
      {:ok, 4}
  """
  defdelegate get_queue_len, to: Player

  @doc """
  Returns the current volume of the default output audio device. This number does not correspond
  directly to the system volume

  ## Examples

      iex> Speakers.get_volume()
      {:ok, 0.5}
  """
  defdelegate get_volume, to: Player

  @doc """
  Sets the current volume of the default output audio device.
  This number does not correspond directly to the system volume

  ## Parameters

    - new_volume: Float value for the volume. Note that this must be between `0.0` to `1.0`.

  ## Examples

      iex> Speakers.set_volume(0.7)
      {:ok, 0.7}
  """
  defdelegate set_volume(new_volume), to: Player
end
