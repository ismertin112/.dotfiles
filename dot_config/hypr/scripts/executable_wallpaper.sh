#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures"
RAW_FILE="$WALLPAPER_DIR/waifu_raw.jpg"
FINAL_FILE="$WALLPAPER_DIR/waifu.jpg"

mkdir -p "$WALLPAPER_DIR"

# swww init
swww query &>/dev/null || swww init

NSFW="false"
[[ "$1" == "--nsfw" ]] && NSFW="true"

TAGS=("waifu" "maid" "uniform")
MAX_ATTEMPTS=10
attempt=1

while (( attempt <= MAX_ATTEMPTS )); do
  RANDOM_TAG=${TAGS[$RANDOM % ${#TAGS[@]}]}
  echo "🔄 Попытка $attempt/$MAX_ATTEMPTS | Тег: $RANDOM_TAG"

  URL=$(curl -s "https://api.waifu.im/search?included_tags=${RANDOM_TAG}&orientation=landscape&is_nsfw=${NSFW}" | jq -r '.images[0].url')

  if [[ -z "$URL" || "$URL" == "null" ]]; then
    echo "❌ Нет картинки, пробуем другой тег..."
    ((attempt++))
    continue
  fi

  curl -s -L -o "$RAW_FILE" "$URL"
  [[ ! -f "$RAW_FILE" ]] && echo "❌ Не удалось скачать" && ((attempt++)) && continue

  read WIDTH HEIGHT <<< $(identify -format "%w %h" "$RAW_FILE")
  ASPECT=$(awk "BEGIN { printf \"%.2f\", $WIDTH / $HEIGHT }")
  echo "ℹ️ Размер: ${WIDTH}x${HEIGHT}, соотношение: $ASPECT"

  # Обработка
  magick "$RAW_FILE" -resize 1920x1080^ -gravity center -extent 1920x1080 "$FINAL_FILE"

  swww img "$FINAL_FILE" --transition-type grow --transition-fps 60

  echo "✅ Установлена вайфу ($RANDOM_TAG): $URL"
  exit 0
done

echo "❌ Не удалось найти подходящую вайфу после $MAX_ATTEMPTS попыток."
exit 1
