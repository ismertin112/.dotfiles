#!/usr/bin/env bash

chosen=$(cliphist list | rofi -dmenu -theme ~/.config/rofi/launchers/type-2/style-2.rasi -p "📋 Clipboard")
[ -n "$chosen" ] && cliphist decode <<<"$chosen" | wl-copy && notify-send "📋 Буфер обмена" "$(wl-paste)"
