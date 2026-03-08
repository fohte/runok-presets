# runok-presets

Official preset collection for [runok](https://github.com/fohte/runok).

## Presets

| File | Description |
| --- | --- |
| `base.yml` | Bundles all presets below via `extends`. Use this for a quick start. |
| `definitions.yml` | Wrapper command definitions (`bash -c`, `sudo`, `xargs`, `find -exec`, etc.) for recursive command evaluation. |
| `readonly-unix.yml` | Allow rules for common read-only Unix commands (`cat`, `grep`, `find`, `sed` without `-i`, etc.). |
| `readonly-git.yml` | Allow rules for read-only git subcommands (`status`, `diff`, `log`, `branch --list`, etc.). |

## Usage

Add an `extends` entry in your `runok.yml`:

```yaml
# Use the base preset (includes all presets)
extends:
  - 'github:fohte/runok-presets/base'

rules:
  # Add your own rules here
  - allow: 'npm test'
```

You can also pick individual presets:

```yaml
extends:
  - 'github:fohte/runok-presets/definitions'
  - 'github:fohte/runok-presets/readonly-git'
```

## License

See [LICENSE](LICENSE) for details.
