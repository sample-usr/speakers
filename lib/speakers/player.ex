defmodule Speakers.Player do
  alias Speakers.NifAudio

  def add_to_queue(url) do
    NifAudio.add_to_queue(url)
  end

  def pause() do
    NifAudio.pause()
  end

  def resume() do
    NifAudio.resume()
  end

  def get_queue_len() do
    NifAudio.get_queue_len()
  end

  def get_volume() do
    NifAudio.get_volume()
  end

  def set_volume(new_volume) do
    NifAudio.set_volume(new_volume)
  end
end
