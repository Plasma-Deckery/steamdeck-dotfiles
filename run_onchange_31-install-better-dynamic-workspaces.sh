#!/usr/bin/env bash
set -eu

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

repo_dir="$tmpdir/kyanite"
git clone --depth=1 https://github.com/Plasma-Deckery/kyanite.git "$repo_dir" >/dev/null

kpackagetool6 --type=KWin/Script -u "$repo_dir" 2>/dev/null || \
  kpackagetool6 --type=KWin/Script -i "$repo_dir"

kwriteconfig6 --file kwinrc --group Plugins --key kyaniteEnabled true

qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript kyanite >/dev/null 2>&1 || true
qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.start >/dev/null 2>&1 || true
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || \
  qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
