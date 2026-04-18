#!/usr/bin/env bash

until curl ifconfig.me > /dev/null 2>&1; do
	sleep 1
done

sudo systemctl start tailscaled

if ip a | grep -q 192.168.0.228; then
	tailscale set --exit-node=
	notify-send "exit node inactive"
else                              
	toggle_node_script.sh &
fi

