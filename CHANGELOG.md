## [2.0.0] - 2024-09-30
### New
- Use tailwindcss-ruby gem as a wrapper for executable.
- Expose `input` and `output` parameters in _config.yml.
- It's possible to minimize output now
- support for postcss was added.
- `rake` was added as a dev dependency, to publish updates with `rake release`.

### Changed
- `config_path` is currently deprecated and will be replaced with `config`

### Removed
- `version` setting doesn't do anything anymore, tailwindcss executable version could be managed through Gemfile.

## [1.0.0] - 2024-03-13

- Initial release
- Automatically download Tailwind CLI
- Allow Tailwind CLI version configuration
- Allow custom Tailwind configuration file path
