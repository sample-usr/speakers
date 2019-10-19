defmodule Speakers.MixProject do
  use Mix.Project

  def project do
    [
      app: :speakers,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      description: description(),
      package: package(),
      rustler_crates: [
        speakers_nifaudio: [
          path: "native/speakers_nifaudio",
          mode: if(Mix.env() == :prod, do: :release, else: :debug)
        ]
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.21.0"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    """
    Library for playing remote audio files
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Raza Gill"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/razagill/speakers"}
    ]
  end
end
