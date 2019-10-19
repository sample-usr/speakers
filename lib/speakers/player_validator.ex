defmodule Speakers.PlayerValidator do
  @moduledoc false

  def is_valid_uri(str) do
    uri = URI.parse(str)
    case uri do
      %URI{scheme: nil} -> {:error, uri}
      %URI{host: nil} -> {:error, uri}
      %URI{path: nil} -> {:error, uri}
      uri -> {:ok, uri}
    end
  end

  def is_valid_volume(volume) do
    new_volume = volume >= 0.0 && volume <= 1.0
    case new_volume do
      false -> {:error, false}
      true -> {:ok, new_volume}
    end
  end
end
