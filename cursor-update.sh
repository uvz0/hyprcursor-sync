#!/usr/bin/env bash
# Hyprland Cursor Updater (One-Shot)
set -e

# --- Configuration ---
CURSOR_CONF="$HOME/.config/hypr/cursors.conf"
ICON_THEME_FILE="$HOME/.local/share/icons/default/index.theme"

# --- Logic ---
get_theme() {
    if [[ -f "$ICON_THEME_FILE" ]]; then
        # Extract theme name, handling spaces/tabs safely
        awk -F= '/Inherits/ {gsub(/[ \t]/, "", $2); print $2}' "$ICON_THEME_FILE"
    else
        echo "Bibata-Modern-Ice"
    fi
}
get_size () {
    grep "gtk-cursor-theme-size" ~/.config/gtk-3.0/settings.ini | cut -d'=' -f2
}

# Ensure config dir exists
mkdir -p "$(dirname "$CURSOR_CONF")"

THEME=$(get_theme)
SIZE=$(get_size)
SIZE="${SIZE:-24}"

# 1. Update Persistent Config
cat > "$CURSOR_CONF" <<EOF
env = HYPRCURSOR_THEME,$THEME
env = HYPRCURSOR_SIZE,$SIZE
env = XCURSOR_THEME,$THEME
env = XCURSOR_SIZE,$SIZE
EOF

# 2. Update Active Session
hyprctl setcursor "$THEME" "$SIZE" >/dev/null 2>&1
hyprctl setenv XCURSOR_SIZE "$SIZE"
hyprctl setenv HYPRCURSOR_SIZE "$SIZE"

gsettings set org.gnome.desktop.interface cursor-theme '$THEME'
gsettings set org.gnome.desktop.interface cursor-size $SIZE
echo "Cursor updated to: $THEME, $SIZE"
