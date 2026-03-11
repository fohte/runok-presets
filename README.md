# runok-presets

Official preset collection for [runok](https://github.com/fohte/runok).

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

## Presets

This collection covers tools that virtually every developer uses regardless of stack — currently common Unix utilities, popular modern alternatives, and git.

Tools whose usage varies by project or team — such as infrastructure tools (docker, kubectl), cloud CLIs (aws, gcloud, az), language runtimes (node, python), and package managers (npm, cargo) — are not included. Define rules for those in your own `runok.yml`.

| File                | Description                                                                                                        |
| ------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `base.yml`          | Bundles all presets below via `extends` and adds universal `--help`/`--version` rules. Use this for a quick start. |
| `definitions.yml`   | Wrapper command definitions (`bash -c`, `sudo`, `xargs`, `find -exec`, etc.) for recursive command evaluation.     |
| `readonly-unix.yml` | Allow rules for common read-only Unix commands (`cat`, `grep`, `find`, `sed` without `-i`, etc.).                  |
| `readonly-git.yml`  | Allow rules for read-only git subcommands (`status`, `diff`, `log`, `branch --list`, etc.).                        |

## Known Risks

These presets are building blocks for runok's command permission rules, not a complete security policy. The level of protection depends entirely on which presets you choose and how you combine them with your own rules.

While the presets are designed to allow only read-only operations, their rule patterns may not cover every edge case. Review the preset files to confirm they match your security requirements before use.

If you find a rule that permits unintended or potentially dangerous commands, please [open an issue](https://github.com/fohte/runok-presets/issues) or submit a pull request.

## License

[MIT](LICENSE)
