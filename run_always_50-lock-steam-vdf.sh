#!/bin/bash
# Locks Steam controller VDF files with chattr +i so Steam cannot overwrite them.
# Runs on every chezmoi apply — the lock is lost after system updates and needs to be re-applied.

VDF="$HOME/.local/share/Steam/controller_base/desktop_neptune.vdf"

if [ ! -f "$VDF" ]; then
    echo "lock-steam-vdf: $VDF not found, skipping."
    exit 0
fi

if lsattr "$VDF" 2>/dev/null | grep -q '\-i\-'; then
    echo "lock-steam-vdf: $VDF already immutable, nothing to do."
    exit 0
fi

sudo chattr +i "$VDF"
echo "lock-steam-vdf: $VDF locked."
