#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar on all monitors
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main --config=~/.config/polybar/config.ini &
  done
else
  polybar --reload main --config=~/.config/polybar/config.ini &
fi

echo "Polybar launched..."
