#!/usr/bin/env bash
set -eu

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

repo_dir="$tmpdir/maximized-window-gaps"
git clone --depth=1 https://github.com/MrAdrianPl/maximized-window-gaps.git "$repo_dir" >/dev/null

python - <<PY2
from pathlib import Path
p = Path("$repo_dir/contents/code/main.js")
text = p.read_text()
text = text.replace(
'''function applyGapsArea(client) {
    let grid = getGrid(client);
    let win = client.frameGeometry;
''',
'''function applyGapsArea(client) {
    let maximizeArea = workspace.clientArea(KWin.MaximizeArea, client);
    if (client.frameGeometry.x === maximizeArea.x
        && client.frameGeometry.y === maximizeArea.y
        && client.frameGeometry.width === maximizeArea.width
        && client.frameGeometry.height === maximizeArea.height) {
        client.setMaximize(false, false);
    }

    let grid = getGrid(client);
    let win = Object.assign({}, client.frameGeometry);
''')
needle = "    for (let i = 0; i < Object.keys(grid.bottom).length; i++) {\n        let pos = Object.keys(grid.bottom)[i];\n        let coords = grid.bottom[pos];\n        if (nearArea(win.bottom, coords, config.gapBottom)) {\n            let diff = win.bottom - coords.gapped;\n            win.height -= diff;\n            break;\n        }\n    }\n}"
replacement = "    for (let i = 0; i < Object.keys(grid.bottom).length; i++) {\n        let pos = Object.keys(grid.bottom)[i];\n        let coords = grid.bottom[pos];\n        if (nearArea(win.bottom, coords, config.gapBottom)) {\n            let diff = win.bottom - coords.gapped;\n            win.height -= diff;\n            break;\n        }\n    }\n\n    client.frameGeometry = win;\n}"
if 'client.frameGeometry = win;' not in text:
    text = text.replace(needle, replacement)
start = text.index('function ignoreClient(client) {')
end = text.index('\n}', start) + 2
ignore_new = '''function ignoreClient(client) {
    return !client
        ||
        ["plasmashell", "krunner", "ksmserver-logout-greeter", "plasma-greeter"].includes(String(client.resourceClass))
        ||
        client.move || client.resize
        ||
        client.fullScreen;
}'''
text = text[:start] + ignore_new + text[end:]
p.write_text(text)
PY2

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
