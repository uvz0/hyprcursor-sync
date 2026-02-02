#!/usr/bin/env bash

echo "[ + ]: Welcome, lets end your cursor updating sufferings r8 now! :) "

# 1. Create the systemd user directory (fixed typo: systend -> systemd)
mkdir -p "$HOME/.config/systemd/user"

# 2. Copy the files
cp cursor-update.sh "$HOME/.config/systemd/user/"
cp cursor-update.path "$HOME/.config/systemd/user/"
cp cursor-update.service "$HOME/.config/systemd/user/"

# 3. Make the script executable
chmod +x "$HOME/.config/systemd/user/cursor-update.sh"

# 4. Reload and Enable
systemctl --user daemon-reload
systemctl --user enable --now cursor-update.path

echo "[ + ]: Installation Complete, HEHE"
