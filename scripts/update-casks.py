#!/usr/bin/env python3
"""Refresh casks from public stable releases after verifying the DMG bytes."""

import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile


APPS = {
    "index-one": ("index-one-landing-page", "IndexOne-{version}.dmg"),
    "rig-one": ("rig-one-landing-page", "RigOne_{version}_aarch64.dmg"),
}
ROOT = Path(__file__).resolve().parent.parent


def download(url, destination):
    subprocess.run(
        ["curl", "--fail", "--silent", "--show-error", "--location",
         "--proto", "=https", "--proto-redir", "=https", "--retry", "2",
         "--connect-timeout", "20", "--max-time", "600",
         "--output", str(destination), url], check=True,
    )


def refresh(app, directory):
    repo, pattern = APPS[app]
    metadata = directory / f"{app}.json"
    download(f"https://api.github.com/repos/monoone-dev/{repo}/releases/latest", metadata)
    release = json.loads(metadata.read_text())
    tag = release["tag_name"]
    if release["draft"] or release["prerelease"] or not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"{app}: expected a published stable vX.Y.Z release")
    version = tag[1:]
    filename = pattern.format(version=version)
    base = f"https://github.com/monoone-dev/{repo}/releases/download/{tag}/"
    assets = {asset["name"]: asset for asset in release["assets"]}
    for name in (filename, "SHA256SUMS.txt"):
        if assets[name]["browser_download_url"] != base + name:
            raise ValueError(f"{app}: unexpected asset URL for {name}")
    sums = directory / f"{app}-SHA256SUMS.txt"
    download(base + "SHA256SUMS.txt", sums)
    matches = []
    for line in sums.read_text().splitlines():
        match = re.fullmatch(r"([a-fA-F0-9]{64})\s+\*?(.+)", line)
        if match and match[2] == filename:
            matches.append(match[1].lower())
    if len(matches) != 1:
        raise ValueError(f"{app}: expected exactly one checksum for {filename}")
    dmg = directory / filename
    print(f"{app}: downloading and verifying {filename}", flush=True)
    download(base + filename, dmg)
    hasher = hashlib.sha256()
    with dmg.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            hasher.update(chunk)
    digest = hasher.hexdigest()
    if digest != matches[0]:
        raise ValueError(f"{app}: DMG does not match SHA256SUMS.txt")
    api_digest = assets[filename].get("digest")
    if api_digest and api_digest != f"sha256:{digest}":
        raise ValueError(f"{app}: DMG does not match GitHub asset digest")
    path = ROOT / "Casks" / f"{app}.rb"
    current = path.read_text()
    updated, versions = re.subn(r'^  version "[^"]+"$', f'  version "{version}"', current, flags=re.M)
    updated, hashes = re.subn(r'^  sha256 "[a-f0-9]{64}"$', f'  sha256 "{digest}"', updated, flags=re.M)
    if versions != 1 or hashes != 1:
        raise ValueError(f"{app}: unexpected cask version or checksum format")
    old_version = re.search(r'^  version "([^"]+)"$', current, re.M)[1]
    if tuple(map(int, version.split("."))) < tuple(map(int, old_version.split("."))):
        raise ValueError(f"{app}: refusing downgrade from {old_version} to {version}")
    print(f"{app}: {version}, SHA256 verified ({digest})")
    return path, current, updated


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("app", choices=[*APPS, "all"])
    parser.add_argument("--check", action="store_true", help="verify without writing; fail if stale")
    args = parser.parse_args()
    selected = list(APPS) if args.app == "all" else [args.app]
    with tempfile.TemporaryDirectory(prefix="monoone-casks-") as temporary:
        results = [refresh(app, Path(temporary)) for app in selected]
    stale = [path.name for path, current, updated in results if current != updated]
    if args.check:
        if stale:
            parser.exit(1, f"Casks need updating: {', '.join(stale)}\n")
        print("Casks match the latest public stable releases.")
    else:
        for path, current, updated in results:
            if current != updated:
                path.write_text(updated)
        print("Updated: " + (", ".join(stale) if stale else "already current"))


if __name__ == "__main__":
    try:
        main()
    except (KeyError, ValueError, OSError, subprocess.CalledProcessError) as error:
        raise SystemExit(f"update-casks: {error}") from error
