#!/bin/sh
mkdir -p /opt/lib/xkeen/modules /opt/etc/xray /opt/var/log
opkg update && opkg install sing-box jq curl iptables ip-full cron
cp S24kte /opt/etc/init.d/S24kte && chmod +x /opt/etc/init.d/S24kte
/opt/etc/init.d/S10cron start && /opt/etc/init.d/S10cron enable
echo "Установка завершена!"
