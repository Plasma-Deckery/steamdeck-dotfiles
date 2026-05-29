#!/usr/bin/env bash
set -eu

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

repo_dir="$tmpdir/maximized-window-gaps"
git clone --depth=1 https://github.com/Plasma-Deckery/maximized-window-gaps.git "$repo_dir" >/dev/null

kpackagetool6 --type=KWin/Script -u "$repo_dir" 2>/dev/null || \
  kpackagetool6 --type=KWin/Script -i "$repo_dir"

kwriteconfig6 --file kwinrc --group Plugins --key maximized-window-gapsEnabled true
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key gapTop 40
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key gapLeft 40
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key gapRight 40
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key gapBottom 40
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key excludeMode true
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key includeMode false
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key excludedApps ''
kwriteconfig6 --file kwinrc --group Script-maximized-window-gaps --key includedApps ''

qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript maximized-window-gaps >/dev/null 2>&1 || true
qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.start >/dev/null 2>&1 || true
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || \
  qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
