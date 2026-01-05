#!/bin/sh

# Параметры проекта
USER="PaPaAltay"
REPO="xKeen-KTE-"
RAW_URL="https://raw.githubusercontent.com/$USER/$REPO/main"

echo "=== Установка xKeen (KTE) ==="

# 1. Обновление и установка зависимостей
echo "[1/4] Установка системных пакетов..."
opkg update
# Пробуем установить sing-box, если не выйдет - выводим подсказку
opkg install sing-box jq curl iptables ip-full cron || echo "Внимание: sing-box не найден, установите его вручную или проверьте архитектуру!"

# 2. Создание структуры папок
echo "[2/4] Создание папок..."
mkdir -p /opt/lib/xkeen/modules
mkdir -p /opt/etc/xray
mkdir -p /opt/bin

# 3. Скачивание файлов с GitHub
echo "[3/4] Скачивание компонентов..."
cd /opt/lib/xkeen/

curl -sL "$RAW_URL/xkeen" -o /opt/bin/xkeen
curl -sL "$RAW_URL/version" -o /opt/lib/xkeen/version
curl -sL "$RAW_URL/S24kte" -o /opt/etc/init.d/S24kte

# Скачивание модулей
curl -sL "$RAW_URL/modules/network.sh" -o /opt/lib/xkeen/modules/network.sh
curl -sL "$RAW_URL/modules/diag.sh" -o /opt/lib/xkeen/modules/diag.sh
curl -sL "$RAW_URL/modules/singbox_gen.sh" -o /opt/lib/xkeen/modules/singbox_gen.sh
curl -sL "$RAW_URL/modules/watchdog.sh" -o /opt/lib/xkeen/modules/watchdog.sh

# 4. Настройка прав
echo "[4/4] Настройка прав доступа..."
chmod +x /opt/bin/xkeen
chmod +x /opt/etc/init.d/S24kte
chmod +x /opt/lib/xkeen/modules/*.sh

# Добавляем xkeen в автодополнение (опционально)
ln -sf /opt/bin/xkeen /opt/bin/xk 2>/dev/null

echo "------------------------------------------------"
echo "Установка завершена! Запустите меню командой: xkeen"
echo "------------------------------------------------""
