# MonoOne Homebrew tap

Install [IndexOne](https://index-one.io/) and [RigOne](https://rig-one.io/) with Homebrew.
The casks download signed, notarized DMGs from public GitHub Releases and verify their SHA256.
Both apps require an Apple Silicon Mac (M1 or later).
IndexOne requires macOS 13.4 or later; RigOne requires macOS 13.0 or later.

## Install

```sh
brew tap monoone-dev/tap
brew install --cask index-one rig-one
```

Or install either app directly:

```sh
brew install --cask monoone-dev/tap/index-one
brew install --cask monoone-dev/tap/rig-one
```

Open the apps from Applications and grant the permissions requested during setup.
If an app is already installed manually, Homebrew may report that its `.app` already exists.
For an identical published version, use Homebrew's `--adopt` option to take over that installation;
otherwise keep the existing installation or move its app bundle before installing the cask.
Do not delete application data.

## Update

```sh
brew update
brew upgrade --cask --greedy index-one rig-one
```

Both apps support in-app updates. `--greedy` includes casks marked as self-updating.
Quit an app before replacing it with Homebrew.

## Uninstall

```sh
brew uninstall --cask index-one rig-one
```

This removes the application bundles. The casks do not delete notebooks, settings or workspaces.

## Maintain a release

After publishing the stable DMG and `SHA256SUMS.txt` to the app's public release, update this tap
in a fresh branch. The helper requires Python 3.11+ and curl, and only accesses public endpoints:

```sh
python3 scripts/update-casks.py index-one
# Or: python3 scripts/update-casks.py rig-one
# Or: python3 scripts/update-casks.py all
```

It downloads the latest stable DMG, verifies `SHA256SUMS.txt` and the GitHub asset digest when
available, then updates the version and hash. It rejects downgrades and verifies every selected
app before writing. It does not publish a release, commit, push or merge.

Review the diff, then validate with a tap checkout at that revision:

```sh
brew style --cask Casks/index-one.rb Casks/rig-one.rb
brew audit --cask --strict --online monoone-dev/tap/index-one monoone-dev/tap/rig-one
brew livecheck --cask monoone-dev/tap/index-one monoone-dev/tap/rig-one
python3 scripts/update-casks.py all --check
```

Commit and merge the verified updates to make the release available through Homebrew.
`livecheck` reports upstream versions; it does not publish cask updates automatically.

Artifacts: [IndexOne releases](https://github.com/monoone-dev/index-one-landing-page/releases)
and [RigOne releases](https://github.com/monoone-dev/rig-one-landing-page/releases).
