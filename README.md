# Тестовое задание


### Сделал отдельный скрипт test.sh(который считает от 0 до бесконечности) для которого и делается мониторинг.



## Создание юнита в systemd
 /etc/systemd/system/monitor_test.service:
 
#### [Unit]
#### Description=Monitoring for test process
#### After=network.target

#### [Service]
#### Type=simple
#### ExecStart=/usr/local/bin/monitoring_test_process.sh
#### Restart=always
#### RestartSec=60

#### [Install]
#### WantedBy=multi-user.target

### Обновить конфигурацию systemd и включить автозапуск:
#### systemctl daemon-reload
#### systemctl enable monitor_test.service
#### systemctl start monitor_test.service
