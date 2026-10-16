#!/usr/bin/env bash
# Decides whether the cask needs a new version, and checks that the DMG it
# will point at is the one the release recorded in SHA256SUMS.txt.
# Writes submit, version and sha256 to $GITHUB_OUTPUT.
set -euo pipefail

BASE_URL=https://releases.seqora.dev
CASK_FILE=Casks/seqora.rb
OUTPUT=${GITHUB_OUTPUT:-/dev/stdout}

skip() {
  echo "$1"
  echo "submit=false" >> "$OUTPUT"
  exit 0
}

current=$(sed -nE 's/^  version "([^"]+)"$/\1/p' "$CASK_FILE")
[[ -n "$current" ]] || { echo "::error::Could not read the version from $CASK_FILE."; exit 1; }

version=${REQUESTED_VERSION:-}
version=${version#v}
if [[ -z "$version" ]]; then
  version=$(curl --fail --silent --show-error --location "$BASE_URL/channels/tester/latest.json" | jq -r '.version')
fi
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]] || { echo "::error::'$version' is not a release version."; exit 1; }

if [[ "$version" == *-* ]]; then skip "$version is a prerelease; the cask tracks stable releases."; fi
if [[ "$version" == "$current" ]]; then skip "The cask is already at $version."; fi
newest=$(printf '%s\n%s\n' "$current" "$version" | sort -V | tail -n 1)
if [[ "$newest" != "$version" && "${ALLOW_DOWNGRADE:-false}" != true ]]; then
  skip "$version is older than the cask's $current."
fi

dmg="Seqora_${version}_aarch64.dmg"
release="$BASE_URL/releases/$version"
expected=$(curl --fail --silent --show-error --location "$release/SHA256SUMS.txt" |
  awk -v file="$dmg" '$2 == file || $2 == "*" file { print tolower($1) }')
[[ "$expected" =~ ^[0-9a-f]{64}$ ]] || { echo "::error::$release/SHA256SUMS.txt has no entry for $dmg."; exit 1; }

download=$(mktemp)
trap 'rm -f "$download"' EXIT
curl --fail --silent --show-error --location --output "$download" "$release/downloads/$dmg"
actual=$(shasum -a 256 "$download" | cut -d ' ' -f 1)
if [[ "$actual" != "$expected" ]]; then
  echo "::error::$dmg hashes to $actual, but SHA256SUMS.txt records $expected."
  exit 1
fi

echo "Updating the cask from $current to $version ($actual)."
{
  echo "submit=true"
  echo "version=$version"
  echo "sha256=$actual"
} >> "$OUTPUT"
