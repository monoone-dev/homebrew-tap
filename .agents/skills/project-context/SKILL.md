---
name: project-context
description: Use before planning, changing or verifying MonoOne Homebrew distribution; explains domain, architecture, commands and verification boundaries.
---

# MonoOne Homebrew distribution

Read this repository AGENTS.md first; workspace git policy and current owner instructions take precedence. Read the relevant project card, then confirm paths and commands in source.

Ruby Casks/index-one.rb and Casks/rig-one.rb; Python scripts/update-casks.py validates published stable DMGs, immutable release URLs, versions and SHA256.

Read README.md and AGENTS.md. Only update after the corresponding public release exists; use scripts/update-casks.py rather than hand-inventing hashes or URLs.

python3 scripts/update-casks.py all --check. For changed casks run brew style --cask, brew audit --cask --strict --online and brew livecheck --cask with the qualified tap names from AGENTS.md in a tap containing the reviewed revision.

Public metadata only. Never sha256 :no_check, mutable URLs, secrets or private links. Never add zap deletion of user notebooks, keys, settings or workspaces. Installing/upgrading apps is separate from validating a cask.

Add tests only when explicitly requested. Run narrow checks for the change; full gates, version bumps and releases belong only to an owner-requested release. Report exact revision and distinguish static checks, mocked runtime, native runtime and production evidence.
