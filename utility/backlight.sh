#!/usr/bin/bash

brightness=$(cat /sys/class/leds/tpacpi::kbd_backlight/brightness)

if [ "$brightness" != 2 ]; then
	((brightness+=1))
else
	brightness=0
fi

echo $brightness | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness

