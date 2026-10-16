#!/usr/bin/env bash
# Lints, audits, installs and zaps the Seqora cask the way a user would.
# Runs on an Apple Silicon macOS runner with this tap set up by
# Homebrew/actions/setup-homebrew.
set -euo pipefail

CASK=ayushman-git/seqora/seqora
APP=/Applications/Seqora.app

brew style --cask "$CASK"
brew audit --cask --strict --online "$CASK"

brew install --cask "$CASK"

expected=$(brew info --cask --json=v2 "$CASK" | jq -r '.casks[0].version')
installed=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist")
if [[ "$installed" != "$expected" ]]; then
  echo "::error::Installed Seqora.app is $installed, but the cask says $expected."
  exit 1
fi

# Homebrew disables casks that fail Gatekeeper, so check it here first.
spctl --assess --type execute --verbose=2 "$APP"
xcrun stapler validate "$APP"

brew uninstall --cask --zap "$CASK"
if [[ -e "$APP" ]]; then
  echo "::error::$APP is still there after uninstalling."
  exit 1
fi
