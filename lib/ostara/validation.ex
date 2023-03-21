defmodule Ostara.Validation do
  @moduledoc """
  Functions for converting `Ecto.Changeset` validators into JSON Schema
  type-specific validations.
  """

  require Logger
  alias Ostara.JSONSchema

  @type ast() :: {marker :: atom(), metadata :: keyword(), args :: list()}

  @doc """
  Annotates the `"properties"` in the given `map` based on the
  `changeset/1` function defined in the `module`.
  """
  @spec put_validations(map(), atom()) :: map()
  def put_validations(%{"properties" => _} = map, module) do
    [pipeline | rest] = get_changeset_ast(module)

    pipeline
    |> Macro.unpipe()
    |> Kernel.++(rest)
    |> Enum.map(fn x ->
      case x do
        {x, _} -> x
        _ -> x
      end
    end)
    |> Enum.reduce(map, &apply_validation/2)
  end

  @spec apply_validation(ast(), map()) :: map()
  defp apply_validation({:validate_required, _, [list]}, map) do
    required = Enum.map(list, &JSONSchema.field_name/1)
    update_required(map, required)
  end

  defp apply_validation({:cast_embed, _, [field, list]}, map) do
    case Keyword.get(list, :required) do
      true ->
        update_required(map, [JSONSchema.field_name(field)])

      _ ->
        map
    end
  end

  defp apply_validation({:validate_number, _, [field, list]}, map) do
    field = JSONSchema.field_name(field)

    validations =
      Enum.reduce(list, %{}, fn {k, v}, acc ->
        case k do
          :less_than -> Map.put(acc, "exclusiveMaximum", v)
          :greater_than -> Map.put(acc, "exclusiveMinimum", v)
          :less_than_or_equal_to -> Map.put(acc, "maximum", v)
          :greater_than_or_equal_to -> Map.put(acc, "minimum", v)
          _ -> acc
        end
      end)

    update_property(map, field, validations)
  end

  defp apply_validation({:validate_length, _, [field, list]}, map) do
    field = JSONSchema.field_name(field)

    validations =
      Enum.reduce(list, %{}, fn {k, v}, acc ->
        case k do
          :min -> Map.put(acc, "minItems", v)
          :max -> Map.put(acc, "maxItems", v)
          _ -> acc
        end
      end)

    update_property(map, field, validations)
  end

  defp apply_validation({name, _, _}, map) when name in [:data, :cast, :cast_embed, :schema] do
    map
  end

  defp apply_validation(validation, map) do
    Logger.warn("No validation: " <> inspect(validation))
    map
  end

  @spec update_required(map(), [String.t()]) :: map()
  defp update_required(map, list) do
    required =
      map
      |> Map.get("required", [])
      |> Kernel.++(list)

    Map.put(map, "required", required)
  end

  @spec update_property(map(), String.t(), term()) :: map()
  defp update_property(map, field, update) do
    updated =
      map
      |> Map.fetch!("properties")
      |> Map.fetch!(field)
      |> Map.merge(update)

    put_in(map, ["properties", field], updated)
  end

  @spec get_changeset_ast(atom) :: [ast()]
  defp get_changeset_ast(module) do
    {_, _, children} =
      module
      |> quote_module()
      |> get_inner_ast()
      |> get_changeset()

    children
  end

  @spec quote_module(atom()) :: Macro.t()
  defp quote_module(module) do
    module
    |> get_module_source()
    |> File.read!()
    |> Code.string_to_quoted!()
  end

  @spec get_module_source(atom()) :: String.t()
  defp get_module_source(module) do
    :compile
    |> module.__info__()
    |> Keyword.fetch!(:source)
  end

  @spec get_inner_ast(ast()) :: ast()
  defp get_inner_ast({:defmodule, _, [_, [{:do, {_, _, module_ast}}]]}) do
    module_ast
  end

  @spec get_changeset_ast(ast()) :: ast()
  defp get_changeset(ast) do
    node =
      Enum.find(ast, fn node ->
        case node do
          {:def, _, [{:changeset, _, _} | _]} -> true
          _ -> false
        end
      end)

    {:def, _, [{:changeset, _, _} | [inner]]} = node

    Keyword.fetch!(inner, :do)
  end
end
