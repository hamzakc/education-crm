defmodule LessonComponent.MixProject do
  use Mix.Project

  def project do
    [
      app: :lesson_component,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
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
      {:crm_core, path: "../crm_core"},
      {:memento, "~> 0.3.1"},
      {:mox, "~> 0.5", only: :test}
    ]
  end

  # Compilation Paths
  defp elixirc_paths(:dev), do: elixirc_paths(:test)
  defp elixirc_paths(:test), do: ["lib", "test/support.ex"]
  defp elixirc_paths(_),     do: ["lib"]
end
