defmodule Speakers.Player do
  @moduledoc false

  alias Speakers.NifAudio

  @spec add_to_queue(String.t()) :: :ok | :error
  def add_to_queue(url) do
    NifAudio.add_to_queue(url)
  end

  @spec pause :: :ok | :error
  def pause() do
    NifAudio.pause()
  end

  @spec resume :: :ok | :error
  def resume() do
    NifAudio.resume()
  end

  @spec get_queue_len :: {:ok, integer()} | :error
  def get_queue_len() do
    NifAudio.get_queue_len()
  end

  @spec get_volume :: {:ok, float()} | :error
  def get_volume() do
    NifAudio.get_volume()
  end

  @spec set_volume(float()) :: {:ok, float()} | :error
  def set_volume(new_volume) do
    NifAudio.set_volume(new_volume)
  end
end
