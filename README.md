# Ostara

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)][Contributor Covenant]

Transforms [Ecto] schema modules into [JSON Schema] structures.

<img alt="Ostara by Johannes Gehrts" width="300" src="https://user-images.githubusercontent.com/423798/225761092-d57dda99-528b-40f1-b3d3-88615321afe3.jpg">

[Ostara _(1901) by Johannes Gehrts_][art]

**Note:** Ostara is under active development and does not yet support all features of Ecto or the full JSON Schema specification. Contributions are welcome!

## Example

Given the following schema module:

```elixir
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
```

Ostara will produce the following data:

```elixir
%{
  "$schema" => "https://json-schema.org/draft/2020-12/schema",
  "$id" => "product",
  "title" => "Product",
  "type" => "object",
  "description" => "A product from Acme's catalog",
  "properties" => %{
    "product_name" => %{
      "type" => "string"
    },
    "price" => %{
      "type" => "number",
      "exclusiveMinimum" => 0
    }
  },
  "required" => ["product_name"]
}
```

## Installation

Ostara is [available in Hex] and can beinstalled by adding `ostara` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ostara, "~> 0.4.0"}
  ]
end
```

## License

Ostara source code is released under Apache License 2.0. See
[LICENSE][LICENSE] for more information.

[Contributor Covenant]: https://github.com/gridpoint-com/ostara/blob/main/CODE_OF_CONDUCT.md
[Ecto]: https://hexdocs.pm/ecto/Ecto.html
[JSON Schema]: https://json-schema.org/
[LICENSE]: https://github.com/gridpoint-com/ostara/blob/main/LICENSE
[art]: https://commons.wikimedia.org/wiki/File:Ostara_by_Johannes_Gehrts.jpg
[available in Hex]: https://hex.pm/ostara
