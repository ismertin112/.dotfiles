#!/bin/bash

LOG="/tmp/neovide-cwd.log"
exec &>"$LOG"

# Получаем PID активного окна
kitty_pid=$(hyprctl activewindow -j | jq .pid)
echo "Kitty window PID: $kitty_pid"

# Находим shell-подпроцесс (bash/zsh/fish и т.п.)
shell_pid=$(ps --ppid "$kitty_pid" -o pid=,comm= | grep -E "zsh|bash|fish" | awk '{print $1}')
echo "Detected shell PID: $shell_pid"

# Если не нашли напрямую — ищем внуков
if [ -z "$shell_pid" ]; then
    echo "Trying to find shell among children recursively..."
    shell_pid=$(ps -eo ppid=,pid=,comm= | grep "$kitty_pid" | grep -E "zsh|bash|fish" | awk '{print $2}')
fi

# Если всё равно не нашли — fallback
if [ -z "$shell_pid" ]; then
    echo "No shell found, using fallback"
    cwd="$HOME"
else
    cwd=$(readlink "/proc/$shell_pid/cwd")
fi

echo "Final CWD: $cwd"

cd "$cwd" || cd ~
echo "Launching neovide in $cwd"
nohup neovide >/dev/null 2>&1 &
