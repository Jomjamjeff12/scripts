#!/usr/bin/env bash
PIDFILE="/tmp/toggle_node_script.sh.pid"

if [ -f "$PIDFILE" ]; then
	kill $(cat "$PIDFILE")
	rm "$PIDFILE"
	tailscale set --exit-node=
	notify-send "Routing is Permenantly Off" "toggle disabled"
else
	exit_node_toggle.sh &
	echo $! > "$PIDFILE"
	tailscale set --exit-node=raspi5
	notify-send "Routing Toggle Enabled" "Routing is on"
fi
