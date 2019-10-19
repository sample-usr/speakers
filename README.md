# Speakers
This library let's you play remote audio streams through the speakers (default output device). It also gives you the ability handle the stream like a media player.

```
iex> Speakers.add_to_queue("http://somedomain.com/somefile.mp3")
```
It uses `rust` via a NIF under the hood and is essentially a wrapper over the excellent library [rodio](https://github.com/RustAudio/rodio)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `speakers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:speakers, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/speakers](https://hexdocs.pm/speakers).
