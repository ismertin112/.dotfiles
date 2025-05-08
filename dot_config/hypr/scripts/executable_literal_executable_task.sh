#!/bin/bash

# Получаем список задач (новая команда)
tasks=$(task status:pending rc.report.list.columns:id,description rc.report.list.labels:on | tail -n +4 | head -n -2 | sed '/^\s*$/d')

# Проверяем, есть ли задачи
if [ -z "$tasks" ]; then
    notify-send "Taskwarrior" "Нет активных задач!"
    exit
fi

# Вызываем rofi
chosen=$(echo "$tasks" | rofi -dmenu -p "Taskwarrior")

# Если ничего не выбрано - выходим
[ -z "$chosen" ] && exit

# Получаем ID задачи
task_id=$(echo "$chosen" | awk '{print $1}')

# Показываем меню действий
action=$(echo -e "Выполнить\nУдалить\nОтложить" | rofi -dmenu -p "Выбери действие")

case "$action" in
    "Выполнить") task "$task_id" done && notify-send "Taskwarrior" "✅ Задача $task_id выполнена!";;
    

    "Удалить") task "$task_id" delete rc.confirmation=off && notify-send "Taskwarrior" "❌ Задача $task_id удалена!";;


    "Отложить") task "$task_id" modify due:tomorrow && notify-send "Taskwarrior" "⏳ Задача $task_id отложена!";;
esac

