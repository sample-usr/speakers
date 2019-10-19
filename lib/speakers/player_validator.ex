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

  def is_valid_volume?(volume) when (volume >= 0.0) and (volume) <= 1.0 do
    true
  end

  def is_valid_volume?(_), do: false
end
