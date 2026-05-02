#!/usr/bin/env bash

until ip_address="$(curl ifconfig.me)" > /dev/null 2>&1; do
	sleep 1
done

sudo systemctl start tailscaled

if [ "$ip_address" = "81.100.7.198" ]; then
	tailscale set --exit-node=
	notify-send "exit node inactive"
else                              
	toggle-node-script.sh &
fi

