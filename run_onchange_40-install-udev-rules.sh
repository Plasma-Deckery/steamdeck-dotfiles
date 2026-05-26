#!/bin/bash
# Installs udev rules for Kando gamepad input recognition.
# chezmoi runs this script only when its content changes.

sudo tee /etc/udev/rules.d/99-kando-gamepad.rules > /dev/null << 'EOF'
SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="Microsoft X-Box 360 pad 0", ENV{ID_INPUT_GAMEPAD}="1"
SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="Steam Deck", ENV{ID_INPUT_GAMEPAD}="1"
SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="Steam Deck", ENV{ID_INPUT_GAMEPAD}="1"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "udev rules installed."
