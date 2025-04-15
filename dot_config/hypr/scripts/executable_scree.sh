#!/bin/bash

# Папка для сохранения скриншотов
SCREENSHOT_DIR="$HOME/Изображения/Screenshots/"
mkdir -p "$SCREENSHOT_DIR"

# Имя файла
FILENAME="$SCREENSHOT_DIR/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

# Делаем скриншот выделенной области
grim -g "$(slurp)" "$FILENAME"

# Копируем в буфер
wl-copy <"$FILENAME"

# Уведомление
notify-send "📸 Скриншот" "Сохранено в $FILENAME и скопировано в буфер" -i camera
