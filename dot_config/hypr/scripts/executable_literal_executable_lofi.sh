#!/bin/bash

# Файл с радиостанциями в JSON-формате
LOFI_JSON="$HOME/.config/hypr/scripts/lofi.json"

# Проверяем, запущен ли MPV
if pgrep -x mpv >/dev/null; then
	pkill mpv
	notify-send "🎵 Радио выключено"
	exit 0
fi

if ! command -v jq &>/dev/null; then
	notify-send "Ошибка" "Установи jq: sudo pacman -S jq"
	exit 1
fi

CHOICE=$(jq -r 'keys[]' "$LOFI_JSON" | rofi -dmenu -p "🎵 Выбери радио:")

[ -z "$CHOICE" ] && exit 1

URL=$(jq -r --arg key "$CHOICE" '.[$key]' "$LOFI_JSON")

notify-send "🎵 Включаю: $CHOICE"

# Если ссылка — это Twitch, запускаем с особым режимом
if [[ "$URL" == *"twitch.tv"* ]]; then
	mpv --no-video --cache=yes --cache-secs=20 --ytdl-format="bestaudio" "$URL"
else
	mpv --no-video "$URL"
fi
