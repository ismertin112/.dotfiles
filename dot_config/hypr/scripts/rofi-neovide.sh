#!/bin/bash

# Папки, где искать файлы
SEARCH_DIR="${1:-$HOME}"

# Выбор файла через rofi
SELECTED=$(find "$SEARCH_DIR" -type f \
    \( -iname "*.md" -o -iname "*.txt" -o -iname "*.lua" -o -iname "*.py" -o -iname "*.cpp" -o -iname "*.rs" \) |
    rofi -dmenu -i -p "Neovide Open:")

# Если файл выбран — открыть в neovide
if [[ -n "$SELECTED" ]]; then
    nohup neovide "$SELECTED" >/dev/null 2>&1 &
    disown
fi
