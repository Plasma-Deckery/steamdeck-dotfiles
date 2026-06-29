#!/usr/bin/env bash
# steam-keyboard-focus-fix: {{ include "dot_local/share/kwin/scripts/steam-keyboard-focus-fix/contents/code/main.js" | sha256sum }}
set -eu

kwriteconfig6 --file kwinrc --group Plugins --key steam-keyboard-focus-fixEnabled true

qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript steam-keyboard-focus-fix >/dev/null 2>&1 || true
qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.start >/dev/null 2>&1 || true
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || \
  qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
