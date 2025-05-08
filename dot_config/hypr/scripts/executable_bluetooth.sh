#!/usr/bin/env bash

bluetoothctl devices | awk '{$1=""; print substr($0,2)}' |
  rofi -dmenu -theme ~/.config/rofi/launchers/type-1/style-2.rasi -p "🔵 Bluetooth" |
  while read -r device; do
    mac=$(bluetoothctl devices | grep "$device" | awk '{print $2}')
    [ -n "$mac" ] && bluetoothctl connect "$mac" && notify-send "🔵 Bluetooth" "Подключено к $device"
  done
