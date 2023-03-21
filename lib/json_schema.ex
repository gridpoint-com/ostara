defmodule Ostara.JSONSchema do
  @moduledoc """
  Functions for transforming an `Ecto.Schema` module into a JSON Schema.
  """

  require Logger

  alias Ostara.Properties
  alias Ostara.Validation

  @doc """
  Transforms the given `source` module into a valid JSON Schema map.
  """
  @spec generate(atom(), [{:root, boolean()}]) :: map()
  def generate(source, opts \\ []) do
    root? = Keyword.get(opts, :root, false)

    %{"type" => "object"}
    |> put_title(source)
    |> put_json_schema_fields(root?)
    |> put_description(source)
    |> Properties.put_properties(source)
    |> Validation.put_validations(source)
  end

  @spec put_title(map(), atom()) :: map()
  defp put_title(map, module) do
    title =
      module
      |> to_string()
      |> String.split(".")
      |> List.last()

    Map.put(map, "title", title)
  end

  @spec put_description(map(), atom()) :: map()
  defp put_description(map, module) do
    case Code.fetch_docs(module) do
      {:docs_v1, _, :elixir, _, %{"en" => module_doc}, _, _} ->
        description = String.trim(module_doc)
        Map.put(map, "description", description)

      _ ->
        map
    end
  end

  @spec put_json_schema_fields(map(), boolean()) :: map()
  defp put_json_schema_fields(map, true) do
    id = Map.fetch!(map, "title")

    fields = %{
      "$schema" => "https://json-schema.org/draft/2020-12/schema",
      "$id" => String.downcase(id)
    }

    Map.merge(map, fields)
  end

  defp put_json_schema_fields(map, false), do: map

  @spec field_name(atom()) :: String.t()
  def field_name(field) do
    [h | t] =
      field
      |> to_string()
      |> String.split("_")

    h <> Enum.map_join(t, &String.capitalize/1)
  end
end
