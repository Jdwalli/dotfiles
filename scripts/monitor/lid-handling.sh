#!/bin/bash
# Script to handle lid state

export DISPLAY=:0
# Should be set in .zprofile
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')

if [ "$LID_STATE" = "closed" ]; then
    # Check if external monitors are connected
    EXTERNAL_MONITORS=$(xrandr | grep " connected" | grep -v "eDP" | wc -l)
    
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
        # Turn off laptop display and move workspaces
        xrandr --output eDP --off
        
        # Move all workspaces from eDP to first external monitor
        FIRST_EXTERNAL=$(xrandr | grep " connected" | grep -v "eDP" | head -n1 | awk '{print $1}')
        
        i3-msg -t get_workspaces | jq -r '.[] | select(.output == "eDP") | .name' | while read -r ws; do
            i3-msg "workspace $ws; move workspace to output $FIRST_EXTERNAL"
        done
        
        i3-msg restart
    fi
else
    # Lid opened - check if external monitors are still connected
    EXTERNAL_MONITORS=$(xrandr | grep " connected" | grep -v "eDP" | wc -l)
    
    if [ "$EXTERNAL_MONITORS" -gt 0 ]; then
        # External monitors present - turn laptop display back on
        # Let autorandr handle the configuration
        autorandr --change --default docked
    else
        # No external monitors - go to mobile mode
        autorandr --change --default mobile
    fi
    
    i3-msg restart
fi
