#!/bin/bash
# Script to handle monitor input changes

export DISPLAY=:0
# Should be set in .zprofile if not, guess
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

sleep 1

# Profile should automatically change:
autorandr --change --default mobile

# Move workspaces from disconnected outputs to active ones
i3-msg -t get_workspaces | jq -r '.[] | select(.output == "eDP" and .visible == false) | .name' | while read -r ws; do
    # Find first active output that isn't eDP
    ACTIVE_OUTPUT=$(i3-msg -t get_outputs | jq -r '.[] | select(.active == true and .name != "eDP") | .name' | head -n1)
    
    if [ -n "$ACTIVE_OUTPUT" ]; then
        i3-msg "workspace $ws; move workspace to output $ACTIVE_OUTPUT"
    fi
done

i3-msg restart
