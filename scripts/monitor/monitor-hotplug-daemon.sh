#!/bin/bash
# Save as: scripts/monitor/monitor-hotplug-daemon.sh
# Daemon that watches for monitor connection events

export DISPLAY=:0
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

echo "Monitor hotplug daemon starting..." >&2

# Watch for DRM events (monitor connect/disconnect)
udevadm monitor --udev --subsystem-match=drm | while read -r line; do
    # Only process change events
    if echo "$line" | grep -q "UDEV.*change"; then
        echo "Monitor change detected: $line" >&2
        
        # Small delay to avoid rapid-fire events
        sleep 1
        
        # Run the monitor handling script
        ~/.local/bin/monitor-handling.sh
    fi
done
