# Ostara

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Transforms [Ecto] schema modules into [JSON Schema] structures.

<img alt="Ostara by Johannes Gehrts" width="300" src="https://user-images.githubusercontent.com/423798/225761092-d57dda99-528b-40f1-b3d3-88615321afe3.jpg">

[Ostara _(1901) by Johannes Gehrts_][art]

**Note:** Ostara is under active development and does not yet support all features of Ecto or the full JSON Schema specification. Contributions are welcome!

## Installation

Ostara is [available in Hex] and can beinstalled by adding `ostara` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ostara, "~> 0.1.0"}
  ]
end
```

## License

Ostara source code is released under Apache License 2.0. See
[LICENSE](LICENSE) for more information.

[Ecto]: https://hexdocs.pm/ecto/Ecto.html
[JSON Schema]: https://json-schema.org/
[art]: https://commons.wikimedia.org/wiki/File:Ostara_by_Johannes_Gehrts.jpg
[available in Hex]: https://hex.pm/ostara
