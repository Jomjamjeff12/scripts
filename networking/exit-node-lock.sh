#!/usr/bin/bash

tailscale set --exit-node=raspi5

notify-send "routing is permenantly on" "regardless of connection"
while ! tailscale status | grep "offers exit node"; do

	if ! ping -c 1 google.com >/dev/null; then
		notify-send "NO INTERNET" "local machine disconnected"
		until ping -c 1 google.com; do
			sleep 1
		done
		notify-send "BACK ONLINE :)"
	elif ! tailscale ping -c 1 raspi5 | grep "pong" >/dev/null 2>&1; then
		notify-send "NO INTERNET" "raspi is offline"
		until tailscale ping -c 1 raspi5 | grep "pong" >/dev/null 2>&1; do
               		sleep 1
                done
                notify-send "BACK ONLINE :)"
	fi

done

