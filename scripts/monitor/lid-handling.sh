#!/bin/bash
# Script to handle lid state

export DISPLAY=:0
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

# Get lid state
LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')

# Count external monitors (excluding laptop display)
EXTERNAL_MONITORS=$(xrandr | grep " connected" | grep -v "eDP" | wc -l)

if [ "$LID_STATE" = "closed" ]; then
    echo "Lid closed - external monitors: $EXTERNAL_MONITORS" >&2
    
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
        # External monitors present - move everything off laptop display
        
        # Get first external monitor name
        FIRST_EXTERNAL=$(xrandr | grep " connected" | grep -v "eDP" | head -n1 | awk '{print $1}')
        
        echo "Moving workspaces to: $FIRST_EXTERNAL" >&2
        
        # Move all workspaces from eDP to external monitor
        i3-msg -t get_workspaces | jq -r '.[] | select(.output == "eDP") | .name' | while read -r ws; do
            echo "Moving workspace $ws to $FIRST_EXTERNAL" >&2
            i3-msg "workspace $ws; move workspace to output $FIRST_EXTERNAL"
        done
        
        # Turn off laptop display
        xrandr --output eDP --off
        
        # Restore wallpaper (no i3 restart needed)
        sleep 0.5
        ~/.local/bin/restore-wallpaper.sh &
    else
        echo "No external monitors - keeping laptop display on" >&2
    fi
else
    echo "Lid opened - external monitors: $EXTERNAL_MONITORS" >&2
    
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
        # External monitors still connected - restore docked profile
        echo "Restoring docked profile with laptop display" >&2
        autorandr --change --default docked
    else
        # No external monitors - go to mobile mode
        echo "Restoring mobile profile" >&2
        autorandr --change --default mobile
    fi
    
    # Restore wallpaper (no i3 restart needed)
    sleep 0.5
    ~/.local/bin/restore-wallpaper.sh &
fi
