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
end
