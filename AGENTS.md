# homebrew-tap

Public Homebrew casks for IndexOne and RigOne. Follow the MonoOne workspace rules.

- `Casks/*.rb`: versioned, SHA256-pinned downloads from public landing-page releases.
- `scripts/update-casks.py`: Python 3.9+ helper; verifies checksums and DMG bytes before updating.
- `README.md`: installation, updates and maintainer instructions.
- Both apps ship Apple Silicon builds. Match macOS requirements to the downloaded app.
- Never use `sha256 :no_check`, mutable download URLs, credentials, private source or private links.
- Do not add `zap` cleanup of notebooks, keys, settings or workspaces.
- English Conventional Commits, `<type>/<topic>` branches, no attribution trailers.
- Add tests only on explicit request. Narrow checks for changed casks:

```sh
brew style --cask monoone-dev/tap/index-one monoone-dev/tap/rig-one
brew audit --cask --strict --online monoone-dev/tap/index-one monoone-dev/tap/rig-one
brew livecheck --cask monoone-dev/tap/index-one monoone-dev/tap/rig-one
python3 scripts/update-casks.py all --check
```

The tap used by the commands must contain the revision being checked.
