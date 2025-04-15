#!/bin/bash

# Папка с обоями
WALLPAPER_DIR="$HOME/Загрузки/pack/"

# Проверяем, существует ли папка
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "❌ Ошибка: папка $WALLPAPER_DIR не найдена!"
    exit 1
fi

# Выбираем случайное изображение
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Проверяем, найден ли файл
if [ -z "$WALLPAPER" ]; then
    echo "❌ Ошибка: в папке нет изображений!"
    exit 1
fi

# Запускаем `swww`, если он ещё не работает
if ! pgrep -x "swww-daemon" >/dev/null; then
    swww init
    sleep 1 # Даем `swww` запуститься
fi

# Меняем обои с плавным переходом
swww img "$WALLPAPER" --transition-type fade --transition-duration 1

echo "✅ Обои обновлены: $WALLPAPER"
