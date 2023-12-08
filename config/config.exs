import Config

config :speakers, Speakers.NifAudio,
  path: "native/speakers_nifaudio",
  mode: if(Mix.env() == :prod, do: :release, else: :debug)
