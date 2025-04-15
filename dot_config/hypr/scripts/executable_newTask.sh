#!/bin/bash

task_desc=$(rofi -dmenu -p "Новая задача:")
[ -z "$task_desc" ] && exit

due_time=$(rofi -dmenu -p "Срок (например, '15:30':")

if [ -z "$due_time" ]; then
    task add "$task_desc" && notify-send "Taskwarrior" "📝 Добавлена задача: $task_desc"
else
    task_id=$(task add "$task_desc" due:$due_time | grep -oP '\d+(?= added)')

    # Ставим напоминание через `at`
    echo "notify-send '⏳ Напоминание' '$task_desc (Дедлайн: $due_time)'" | at "$due_time"

    notify-send "Taskwarrior" "📝 Добавлена задача: $task_desc (до $due_time) с напоминанием"
fi

