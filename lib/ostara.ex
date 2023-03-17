defmodule Ostara do
  @moduledoc """
  `Ostara` transforms [Ecto](https://hexdocs.pm/ecto/Ecto.html) schema
  modules into [JSON Schema](https://json-schema.org/) structures.

  ## Example

  Given the following schema module:

      defmodule Product do
        @moduledoc "A product from Acme's catalog",
        use Ecto.Schema

        @primary_key false

        embedded_schema do
         field :product_name, :string
         field :price, :float
        end

        def changeset(data, params) do
         data
         |> cast(params, [:product_name, :price])
         |> validate_required([:product_name])
         |> validate_number(:price, greater_than: 0)
        end
      end

  `transmute/1` will produce the following map:

      %{
        "$schema" => "https://json-schema.org/draft/2020-12/schema",
        "title" => "Product",
        "type" => "object",
        "description" => "A product from Acme's catalog",
        "properties" => %{
          "productName" => %{
            "type" => "string"
          },
          "price" => %{
            "type" => "number",
            "exclusiveMinimum" => 0
          }
        },
        "required" => ["productName"]
      }
  """

  alias __MODULE__.JSONSchema

  @doc """
  Produces a JSON Schema based on the given `source` module.

  ## Options

    * `:format` - If `:json`, returns the data as pretty-printed JSON

  """
  @spec transmute(atom(), [{:format, atom()}]) :: map()
  def transmute(source, opts \\ []) when is_atom(source) do
    format = Keyword.get(opts, :format)
    schema = JSONSchema.generate(source, root: true)

    if format == :json do
      Jason.encode!(schema, pretty: true)
    else
      schema
    end
  end
end
