#!/usr/bin/env bash
set -eu

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

repo_dir="$tmpdir/better-dynamic-workspaces"
git clone --depth=1 https://github.com/MurderFromMars/Better_Dynamic_Workspaces.git "$repo_dir" >/dev/null

python3 - <<PY2
from pathlib import Path
p = Path("$repo_dir/contents/code/main.js")
text = p.read_text()

# Add updateRows() call in addDesktop
text = text.replace(
    '\taddDesktop: () => {\n\t\tworkspace.createDesktop(workspace.desktops.length, undefined);\n\t},',
    '\taddDesktop: () => {\n\t\tworkspace.createDesktop(workspace.desktops.length, undefined);\n\t\tupdateRows();\n\t},'
)

# Add updateRows() call after removeDesktop
text = text.replace(
    '\t\t\tworkspace.removeDesktop(last);\n\n\t\t\tif (current && current !== last) {',
    '\t\t\tworkspace.removeDesktop(last);\n\t\t\tupdateRows();\n\n\t\t\tif (current && current !== last) {'
)

# Add updateRows function after compat object
text = text.replace(
    '\tdesktopAmount: () => workspace.desktops.length,\n};',
    '\tdesktopAmount: () => workspace.desktops.length,\n};\n\nfunction updateRows() {\n\tconst count = workspace.desktops.length;\n\tworkspace.desktopGridHeight = count;\n\tworkspace.desktopGridWidth = 1;\n}'
)

p.write_text(text)
PY2

kpackagetool6 --type=KWin/Script -u "$repo_dir" 2>/dev/null || \
  kpackagetool6 --type=KWin/Script -i "$repo_dir"

kwriteconfig6 --file kwinrc --group Plugins --key kyaniteEnabled true

qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript kyanite >/dev/null 2>&1 || true
qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.start >/dev/null 2>&1 || true
qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || \
  qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
