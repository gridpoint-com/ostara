defmodule Circe.MixProject do
  use Mix.Project

  def project do
    [
      app: :circe,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo,
       git: "https://github.com/rrrene/credo", branch: "master", runtime: false, override: true},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ecto, "~> 3.8"},
      {:jason, "~> 1.4"}
    ]
  end
end
