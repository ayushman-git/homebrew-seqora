# Seqora for Homebrew

The Homebrew tap for [Seqora](https://seqora.dev/), a database client for PostgreSQL, MySQL, MariaDB and SQLite.

## Install

```bash
brew install ayushman-git/seqora/seqora
```

Seqora needs a Mac with Apple Silicon. It is signed with a Developer ID and notarized by Apple, so it opens without Gatekeeper warnings.

Use the full name above. Homebrew asks you to trust third-party taps before it loads them, and installing by full name trusts this cask for you. If you added the tap with `brew tap` instead, run `brew trust ayushman-git/seqora` once before `brew install seqora`.

## Updates

Seqora updates itself from inside the app, so `brew upgrade` leaves it alone. To update through Homebrew anyway:

```bash
brew upgrade --greedy seqora
```

## Uninstall

```bash
brew uninstall seqora
```

Add `--zap` to also delete Seqora's settings, saved connections and passwords, caches, and custom commands in `~/.seqora`. Homebrew cannot remove Keychain items, so the `com.seqora.app.metadata` key that encrypted the saved connections stays behind. It is useless once they are deleted, and you can remove it in Keychain Access.

## How this tap is maintained

- `Casks/seqora.rb` points at the signed DMG on `releases.seqora.dev` and pins its SHA-256.
- **Bump cask** runs every three hours. When the release feed has a newer stable version, it checks the DMG against the release's `SHA256SUMS.txt`, installs and uninstalls it on an Apple Silicon runner, and commits the new version.
- **Test cask** runs the same checks on every push and pull request.

GitHub disables scheduled workflows in a public repository after 60 days without activity. Each release's bump commit keeps the schedule on, but if Seqora goes 60 days without a release, **Bump cask** silently stops. After such a gap, check `gh workflow list -R ayushman-git/homebrew-seqora --all`; if **Bump cask** shows `disabled_inactivity`, run `gh workflow enable bump.yml -R ayushman-git/homebrew-seqora` and then `gh workflow run bump.yml -R ayushman-git/homebrew-seqora`.

Report problems with the app at [seqora.dev](https://seqora.dev/), and problems with the cask in this repository's issues.
