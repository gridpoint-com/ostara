# Circe

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Converts [Ecto] schema modules into [JSON Schema] structures.

![De_claris_mulieribus](https://user-images.githubusercontent.com/423798/225713530-13c15758-5740-4acc-9200-e274478392bc.jpg)<br>
[_“Circea” in Boccaccio’s c. 1365_ De Claris Mulieribus _, a catalogue of famous women, from a 1474 edition_][art]

**Note:** Circe is under active development and does not yet support all features of Ecto or the full JSON Schema specification. Contributions are welcome!

## Installation

Circe is [available in Hex] and can beinstalled by adding `circe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:circe, "~> 0.1.0"}
  ]
end
```

## License

Circe source code is released under Apache License 2.0. See
[LICENSE](LICENSE) for more information.

[Ecto]: https://hexdocs.pm/ecto/Ecto.html
[JSON Schema]: https://json-schema.org/
[art]: https://commons.wikimedia.org/wiki/File:De_claris_mulieribus.jpg
[available in Hex]: https://hex.pm/circe
