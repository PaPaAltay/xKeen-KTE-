#!/bin/sh
setup_rules() {
    flush_rules
    iptables -t mangle -N KTE_CORE
    iptables -t mangle -A KTE_CORE -d 127.0.0.0/8,192.168.0.0/16 -j RETURN
    iptables -t mangle -A KTE_CORE -p udp --dport 53 -j TPROXY --on-port 10080 --tproxy-mark 0x1/0x1
    iptables -t mangle -I PREROUTING -i br0 -j KTE_CORE
    ip rule add fwmark 1 table 100
    ip route add local default dev lo table 100
}
flush_rules() {
    iptables -t mangle -D PREROUTING -i br0 -j KTE_CORE 2>/dev/null
    iptables -t mangle -F KTE_CORE 2>/dev/null
    iptables -t mangle -X KTE_CORE 2>/dev/null
    ip rule del fwmark 1 table 100 2>/dev/null
}
