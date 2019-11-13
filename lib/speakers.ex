defmodule Speakers do
  @moduledoc """
  Handles playing of audio files through speakers. (mp3, wav, ogg and flac are supported)

  Whichever device is set as the default output, is selected for audio.
  """

  alias Speakers.Player

  @doc """
  Adds an audio file to the queue. If the queue is empty it'll play it immediately

  ## Parameters

    - file_path: String that represents the absolute path of the file

  ## Examples

      iex> Speakers.add_to_queue("/Users/test/Download/audio.mp3")
      {:ok}
  """
  defdelegate add_to_queue(file_path), to: Player

  @doc """
  Pauses the currently playing audio file

  ## Examples

      iex> Speakers.pause()
      :ok
  """
  defdelegate pause, to: Player

  @doc """
  Resumes the currently playing audio file

  ## Examples

      iex> Speakers.resume()
      :ok
  """
  defdelegate resume, to: Player

  @doc """
  Returns the number of audio files in the queue

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
