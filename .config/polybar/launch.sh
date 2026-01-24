#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

  polybar --reload main --config=~/.config/polybar/config.ini &

echo "Polybar launched..."
