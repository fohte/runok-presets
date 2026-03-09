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

# Run tests in an isolated tmpdir to avoid interference from
# runok.local.yml or ancestor directory configs.
empty_xdg=$(mktemp -d)
testdir=$(mktemp -d)
trap 'rm -r "$empty_xdg" "$testdir"' EXIT

# Copy preset files into testdir.
for f in "$repo_root"/*.yml; do
  bn=$(basename "$f")
  [ "$bn" = "runok.yml" ] || [ "$bn" = "runok.local.yml" ] && continue
  cp "$f" "$testdir/$bn"
done

while IFS= read -r test_json; do
  command=$(echo "$test_json" | jq -r '.command')
  expected=$(echo "$test_json" | jq -r '.expected')
  config=$(echo "$test_json" | jq -r '.config')
  description=$(echo "$test_json" | jq -r '.description // empty')

  # Place the target config as runok.yml in testdir.
  cp "$testdir/$config" "$testdir/runok.yml"

  # Run runok check with isolated config:
  # - XDG_CONFIG_HOME points to empty dir (no global config)
  # - Working directory is testdir (isolated from project and ancestor configs)
  # Pipe via stdin to preserve shell quoting (e.g. bash -c "cat /etc/hosts").
  result=$(cd "$testdir" && echo "$command" | XDG_CONFIG_HOME="$empty_xdg" runok check --output-format json 2> /dev/null) || true
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
