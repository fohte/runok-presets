# CLAUDE.md

Official preset collection for [runok](https://github.com/fohte/runok), a command execution permission manager for LLM agents.

## Files

- `base.yml` - Entry point that bundles all presets + rules for `--help`/`--version`/`runok` subcommands
- `definitions.yml` - Wrapper command definitions (`bash -c`, `sudo`, `xargs`, etc.) for recursive evaluation
- `readonly-unix.yml` - Allow rules for read-only Unix commands
- `readonly-git.yml` - Allow rules for read-only git subcommands
- `readonly-gh.yml` - Allow rules for read-only gh subcommands

## Testing

Two kinds of tests exist:

- **Inline tests**: `tests:` field under each rule, verifying that specific rule's allow/ask behavior
- **Global tests**: `tests.cases` field at the end of a file, for cross-rule integration tests (see `definitions.yml`)

Run tests per file:

```sh
runok test -c <file>
# e.g. runok test -c readonly-git.yml
```

## Commit conventions

Use [Conventional Commits](https://www.conventionalcommits.org/). Scope corresponds to the preset filename:

- `feat(readonly-git): add read-only git stash list`
- `fix(readonly-unix): allow sed without -i flag`
- Valid scopes: `base`, `definitions`, `readonly-unix`, `readonly-git`, `readonly-gh`

### Semver type guidelines

The key principle: semver is determined by **user-facing impact on command permissions**, not by code change size.

- **major**: Changes that **break existing workflows** -- previously allowed commands become ask/deny
  - Deleting or narrowing allow rules
  - Changing allow → ask/deny
  - Deleting/renaming preset files
  - Removing presets from `base.yml` extends
  - Deleting/narrowing wrapper definitions
  - Adding/tightening `when` clauses or negation patterns on existing rules
- **minor**: **Structural additions** that don't change existing behavior
  - Adding new preset files
  - Adding new presets to `base.yml` extends
  - Adding new wrapper definitions
  - Adding new definitions categories (paths, vars, sandbox)
- **patch**: Changes that **don't break existing workflows**
  - Adding allow rules (both new commands and variations of existing ones)
  - Expanding allow rule patterns
  - Fixing unintended over-denial (bug fix)
  - Tests, comments, equivalent rewrites, documentation

## Scope policy

Only common Unix tools, git, and gh. Docker, kubectl, AWS CLI, language runtimes, etc. are out of scope.

## Design patterns

- Allow read-only commands; write/destructive operations are `ask` or implicitly blocked (no rule)
- `ask` rules take priority over `allow` rules regardless of order in the file; place `ask` before `allow` for readability
- Negation patterns exclude dangerous flags: e.g. `sed !-i|--in-place *`
- git commands share optional location args: `git [-C *] [--git-dir *] [--work-tree *] <subcommand> *`
- gh commands share optional repo arg: `gh [-R|--repo *] <subcommand> *`

For rule pattern syntax details, use the `/runok` skill.

## CI / Release

- [release-please](https://github.com/googleapis/release-please) automates versioning and releases
- CI runs `runok test -c <file>` for all preset files
