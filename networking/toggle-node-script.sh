#!/usr/bin/env bash
PIDFILE="/tmp/toggle-node-script.sh.pid"

if [ -f "$PIDFILE" ]; then
	kill $(cat "$PIDFILE")
	rm "$PIDFILE"
	tailscale set --exit-node=
	notify-send "Routing is Permenantly Off" "toggle disabled"
else
	exit-node-toggle.sh &
	echo $! > "$PIDFILE"
	tailscale set --exit-node=100.118.65.57
	notify-send "Routing Toggle Enabled" "Routing is on"
fi
