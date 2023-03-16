defmodule Circe.Properties do
  @moduledoc """
  Functions for converting `Ecto.Schema` fields to JSON Schema properties.
  """

  alias Circe.JSONSchema

  @doc """
  Puts a `"properties"` key in the given `map` based on the fields defined
  in the `source`.

  `source` should be an `Ecto.Schema` module.
  """
  @spec put_properties(map(), atom()) :: map()
  def put_properties(map, source) do
    properties = get_properties(source)
    Map.put(map, "properties", properties)
  end

  @spec get_properties(atom()) :: map()
  defp get_properties(source) do
    source
    |> get_fields()
    |> Map.new(fn field ->
      name = JSONSchema.field_name(field)
      type = propertize_type(source.__schema__(:type, field))

      {name, type}
    end)
  end

  @spec get_fields(atom()) :: map()
  defp get_fields(source) do
    source.__schema__(:fields)
  end

  @spec propertize_type(atom()) :: map()
  defp propertize_type(:binary_id) do
    %{"type" => "string"}
  end

  defp propertize_type(:float) do
    %{"type" => "number"}
  end

  defp propertize_type({:array, type}) do
    type =
      type
      |> propertize_type()
      |> Map.fetch!("type")

    %{
      "type" => "array",
      "items" => %{
        "type" => type
      }
    }
  end

  defp propertize_type({:parameterized, Ecto.Embedded, %{related: source}}) do
    Circe.JSONSchema.generate(source)
  end

  defp propertize_type(type) do
    %{"type" => to_string(type)}
  end
end
