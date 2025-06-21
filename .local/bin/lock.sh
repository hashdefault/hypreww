#!/bin/bash

WALLPAPER=$(find ~/Pictures/wallpapers -type f | shuf -n 1)
if [[ $XDG_SESSION_TYPE == 'x11' ]]; then
  betterlockscreen -u "$WALLPAPER"

  xset s 500 &
  xautolock -time 5 -locker "betterlockscreen -l" \
    -notify 30 -notifier "dunstify -i ~/.config/eww/images/lock.svg -a 'Locker' 'Locker  ' 'Locking screen in 30 seconds'" \
    -killtime 10 -killer "systemctl suspend" &

elif [[ $XDG_SESSION_TYPE == 'wayland' ]]; then
  swayidle -w \
    timeout 570 'dunstify -i ~/.config/eww/images/lock.svg -a "Locker" "Locker  " "Locking screen in 30 seconds"' \
    timeout 600 "hyprlock "
fi
