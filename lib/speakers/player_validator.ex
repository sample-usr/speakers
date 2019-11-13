defmodule Speakers.PlayerValidator do
  @moduledoc false
  def is_valid_volume?(volume) when (volume >= 0.0) and (volume) <= 1.0 do
    true
  end

  def is_valid_volume?(_), do: false
end
