defmodule InstaInsta.Mixfile do
  use Mix.Project

  def project do
    [
      app: :insta_insta,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "InstaInsta",
      description: "Instagram JSON and HTML endpoints without a API key, inspired on InstaScrapex",
      package: [
        maintainers: ["Flavio Vinicius"],
        licenses: ["UNLICENSE"],
        links: %{"GitHub" => "https://github.com/PuckOut/insta_insta"}
      ],
      source_url: "https://github.com/PuckOut/insta_insta",
      homepage_url: "https://github.com/PuckOut/insta_insta",
      docs: [
        main: "InstaInsta",
        extras: ["README.md"],
        links: %{
          github: "https://github.com/PuckOut/insta_insta"
        }
      ]
    ]
  end

  def application do
    [
      applications: [:logger, :httpoison]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end
end
