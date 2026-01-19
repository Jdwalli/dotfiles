#!/bin/bash
# Script to handle monitor input changes

export DISPLAY=:0
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

echo "Monitor change detected" >&2

# Wait for display to stabilize
sleep 1

# Let autorandr detect and apply the best profile
echo "Running autorandr..." >&2
autorandr --change --default mobile

# Move workspaces from disconnected outputs to active ones
echo "Checking for orphaned workspaces..." >&2
i3-msg -t get_workspaces | jq -r '.[] | select(.output == "eDP" and .visible == false) | .name' | while read -r ws; do
    # Find first active output that isn't eDP
    ACTIVE_OUTPUT=$(i3-msg -t get_outputs | jq -r '.[] | select(.active == true and .name != "eDP") | .name' | head -n1)
    
    if [ -n "$ACTIVE_OUTPUT" ]; then
        echo "Moving workspace $ws to $ACTIVE_OUTPUT" >&2
        i3-msg "workspace $ws; move workspace to output $ACTIVE_OUTPUT"
    fi
done

# Restore wallpaper (no i3 restart needed)
sleep 0.5
~/.local/bin/restore-wallpaper.sh &

echo "Monitor configuration complete" >&2
