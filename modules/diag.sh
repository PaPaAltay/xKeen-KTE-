#!/bin/sh
run_deep_diag() {
    echo "--- Анализ KTE ---"
    pgrep sing-box >/dev/null && echo "Процесс: OK" || echo "Процесс: DEAD"
    echo -n "Proxy IP: "; curl -s --connect-timeout 5 ifconfig.me || echo "Timeout"
    read -p "Enter..." _
}
