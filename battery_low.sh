#!/usr/bin/bash

bat1=$(cat /sys/class/power_supply/BAT1/capacity)
bat0=$(cat /sys/class/power_supply/BAT0/capacity)


total=$(((($bat1+$bat0)*125)/200))

echo $total
echo $bat1
echo $bat0

if [ $total -le 30 ] && [ $total -ge 15 ]; then
	notify-send "battery is low" 
fi
if [ $total -lt 15 ]; then
        notify-send "battery is very low"
fi
