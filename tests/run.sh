#!/usr/bin/env bash
set -euo pipefail

# Run E2E tests for runok presets.
# Reads test cases from tests/test-cases.yml and verifies each command's
# decision against expected values using `runok check --output-format json`.
#
# Dependencies: runok, yq, jq

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

failures=0
total=0

# Create an empty directory for XDG_CONFIG_HOME to ignore global config.
empty_xdg=$(mktemp -d)
trap 'rm -r "$empty_xdg"; rm -f "$repo_root/runok.yml"' EXIT

while IFS= read -r test_json; do
  command=$(echo "$test_json" | jq -r '.command')
  expected=$(echo "$test_json" | jq -r '.expected')
  config=$(echo "$test_json" | jq -r '.config')
  description=$(echo "$test_json" | jq -r '.description // empty')

  # Create a temporary runok.yml symlink inside the repo root.
  # runok discovers project config by looking for runok.yml in the cwd
  # and its ancestors. For configs with `extends` (e.g. base.yml),
  # relative paths are resolved from the config file's directory,
  # so the symlink must live in the repo root alongside the preset files.
  ln -sf "$repo_root/$config" "$repo_root/runok.yml"

  # Run runok check with isolated config:
  # - XDG_CONFIG_HOME points to empty dir (no global config)
  # - Working directory is repo_root (runok.yml symlinked to target config)
  # shellcheck disable=SC2086 # Intentional word splitting: $command contains multiple arguments
  result=$(cd "$repo_root" && XDG_CONFIG_HOME="$empty_xdg" runok check --output-format json -- $command 2> /dev/null)
  actual=$(echo "$result" | jq -r '.decision')

  total=$((total + 1))
  if [ "$actual" != "$expected" ]; then
    failures=$((failures + 1))
    echo "FAIL: $command"
    echo "  config:   $config"
    echo "  expected: $expected"
    echo "  actual:   $actual"
    [ -n "$description" ] && echo "  note:     $description"
  fi
done < <(yq -o=json '.tests[]' "$repo_root/tests/test-cases.yml" | jq -c '.')

if [ "$total" -eq 0 ]; then
  echo "ERROR: no test cases found"
  exit 1
fi

echo ""
echo "$((total - failures))/$total passed"
[ "$failures" -eq 0 ] && exit 0 || exit 1
