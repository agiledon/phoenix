defmodule <%= app_module %>.Mixfile do
  use Mix.Project

  def project do
    [app: :<%= app_name %>,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [applications: [:logger<%= if ecto do %>, :<%= adapter_app %>, :ecto<% end %>],
     mod: {<%= app_module %>.Application, []}]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [<%= if ecto do %>{:<%= adapter_app %>, ">= 0.0.0"},
     {:ecto, "~> 2.1-rc"}<% end %>]
  end

  # Aliases are shortcuts or tasks specific to the current project.<%= if ecto do %>
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup<% end %>
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [<%= if ecto do %>"ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]<% end %>]
  end
end
