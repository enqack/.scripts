#!/bin/bash

HEAD_NAMES=$(polybar -M | cut -d ':' -f 1)

killall -q polybar

# wait for killall to take effect
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

counter=1
for head in $HEAD_NAMES; do
  export MONITOR=$head

  if [ "$counter" -eq "1" ]; then
    polybar primary --config=$HOME/.config/polybar/primary.ini &
  fi

  if [ "$counter" -eq "2" ]; then
    polybar secondary --config=$HOME/.config/polybar/secondary.ini &
  fi

  if [ "$counter" -gt "2" ]; then
    polybar additional --config=$HOME/.config/polybar/additional.ini &
  fi

  ((counter++))
done

