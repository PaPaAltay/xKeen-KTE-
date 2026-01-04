#!/bin/sh
pgrep sing-box >/dev/null || /opt/etc/init.d/S24sing-box restart
