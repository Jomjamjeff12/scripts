#!/usr/bin/env bash

until ping -c 1 google.com >/dev/null 2>&1; do
        sleep 1
done

while true; do
	# turns off if the pi is disconnected until it is reconnected to the tailnet
	if ! tailscale ping -c 1 raspi5 | grep "pong" >/dev/null 2>&1; then
		notify-send "Routing is off" "Pi is Disconnected"
		tailscale set --exit-node=
		connection_reason="Pi is Reconected"
		until tailscale ping -c 1 raspi5 | grep "pong" >/dev/null 2>&1; do
			sleep 0.5
		done
	fi
       	if tailscale status | grep -q "offers exit node"; then
              	tailscale set --exit-node=raspi5
               	notify-send "Routing is on"       
	fi
        
        sleep 1
done
