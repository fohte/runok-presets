# runok-presets

Official preset collection for [runok](https://github.com/fohte/runok).

## Presets

| File | Description |
| --- | --- |
| `runok.yml` | Entry point that bundles all presets below via `extends`. |
| `definitions.yml` | Wrapper command definitions (`bash -c`, `sudo`, `xargs`, `find -exec`, etc.) for recursive command evaluation. |
| `readonly-unix.yml` | Allow rules for common read-only Unix commands (`cat`, `grep`, `find`, `sed` without `-i`, etc.). |
| `readonly-git.yml` | Allow rules for read-only git subcommands (`status`, `diff`, `log`, `branch --list`, etc.). |

## Usage

Add an `extends` entry in your `runok.yml`:

```yaml
extends:
  - 'github:fohte/runok-presets@v1'

rules:
  # Add your own rules here
  - allow: 'npm test'
```

This loads `runok.yml` from this repository, which in turn includes `definitions.yml`, `readonly-unix.yml`, and `readonly-git.yml`.

## License

See [LICENSE](LICENSE) for details.
