# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.3] - 2023-07-17

### Fixed

- Support for `Ecto.Enum`

## [0.4.2] - 2023-04-21

### Fixed

- Typespec and documentation updates.

## [0.4.1] - 2023-04-21

### Fixed

- Don't issue "no validation" warning when encountering `:schema`.

## [0.4.0] - 2023-04-21

### Added

- Add JSON Schema `$id` keyword.

### Fixed

- Preserve casing of field names.

## [0.3.0] - 2023-04-19

### Added

- Support for embed cardinality, i.e. `:embeds_one` as opposed to `:embeds_many`.

### Fixed

- Don't issue "no validation" warning when using `cast_embed` in a changeset.

## [0.2.1] - 2023-04-17

### Fixed

- Remove trailing newline in description when moduledoc uses heredoc syntax.

## [0.2.0] - 2023-04-17

### Added

- Support for `cast_embed/3`.

## [0.1.0] - 2023-04-16

### Added

- Initial release.

[0.4.2]: https://github.com/gridpoint-com/ostara/releases/tag/v0.4.2
[0.4.1]: https://github.com/gridpoint-com/ostara/releases/tag/v0.4.1
[0.4.0]: https://github.com/gridpoint-com/ostara/releases/tag/v0.4.0
[0.3.0]: https://github.com/gridpoint-com/ostara/releases/tag/v0.3.0
[0.2.1]: https://github.com/gridpoint-com/ostara/releases/tag/v0.2.1
[0.2.0]: https://github.com/gridpoint-com/ostara/releases/tag/v0.2.0
[0.1.0]: https://github.com/gridpoint-com/ostara/releases/tag/v0.1.0
