#!/bin/bash

LOG_FILE="/var/log/monitoring.log"
MONITOR_URL="https://test.com/monitoring/test/api"
PROCESS_NAME="test"

was_running=0
while true; do
    # Проверяем, запущен ли процесс
    if pgrep -x "$PROCESS_NAME" >/dev/null; then
        # Если процесс запущен, стучимся на сервер мониторинга
        if curl -s -o /dev/null --connect-timeout 5 "$MONITOR_URL"; then
            # Сервер доступен, ничего не пишем
            :
        else
            # Сервер недоступен, пишем в лог
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Сервер мониторинга недоступен" >> "$LOG_FILE"
        fi

        # Если процесс был перезапущен
        if [ "$was_running" -eq 0 ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME перезапущен" >> "$LOG_FILE"
        fi
        was_running=1
    else
        was_running=0
    fi

    # Ждем 1 минуту
    sleep 60
done
