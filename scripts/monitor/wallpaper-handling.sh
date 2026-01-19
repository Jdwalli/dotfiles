#!bin/bash
# Script to restore wallpaper across all monitors (Fix the tearing)

export DISPLAY=:0
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

WALLPAPER="${DEFAULT_WALLPAPER_PATH:-$HOME/dotfiles/wallpapers/mountain.jpg}"

sleep 0.5

if [ -f "$WALLPAPER" ]; then
    feh --bg-scale "$WALLPAPER"
else
    echo "Warning: Wallpaper not found at $WALLPAPER" >&2
fi
