#!/bin/bash
# Copy monitor management scripts to ~/.local/bin/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR"

# Copy scripts
echo "Installing monitor management scripts..."
cp "$SCRIPT_DIR/lid-handling.sh" "$TARGET_DIR/"
cp "$SCRIPT_DIR/monitor-handling.sh" "$TARGET_DIR/"
cp "$SCRIPT_DIR/wallpaper-handling.sh" "$TARGET_DIR/"
cp "$SCRIPT_DIR/monitor-hotplug-daemon.sh" "$TARGET_DIR/"

chmod +x "$TARGET_DIR/lid-handling.sh"
chmod +x "$TARGET_DIR/monitor-handling.sh"
chmod +x "$TARGET_DIR/wallpaper-handling.sh"
chmod +x "$TARGET_DIR/monitor-hotplug-daemon.sh"

echo "Scripts installed to $TARGET_DIR"
