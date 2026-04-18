#!/usr/bin/env bash

until ping -c 1 google.com >/dev/null 2>&1; do
	sleep 1
done

notify-send "Updating..."

sudo pacman -Syu --noconfirm &> ~/debug/pacman
pacman_status=$?

yay -Syu --noconfirm &> ~/debug/yay
yay_status=$?

pacman_packages=$(cat ~/debug/pacman | grep Packages | sed 's/.*(//g' | sed 's/).*//g')
yay_packages=$(cat ~/debug/yay | grep "Packages (" | sed 's/.*(//g' | sed 's/).*//g')

if [ -z "$pacman_packages" ]; then
	pacman_packages=0
fi
if [ -z "$yay_packages" ]; then
	yay_packages=0
fi

total_packages=$(($yay_packages+$pacman_packages))

if ! cat ~/debug/yay | grep -q "there is nothing to do" ; then
	update_status+="AUR "
	
fi
if ! cat ~/debug/pacman | grep -q "there is nothing to do" ; then
        if [ "$update_status" == "" ]; then
		update_status+="Pacman"
	else
		update_status+="and Pacman" 
	fi
fi

if [ $yay_status -ne 0 ]; then
	notify-send "AUR update failed" "exit code: $yay_status"
fi
if [ $pacman_status -ne 0 ]; then
        notify-send "Pacman update failed" "exit code: $pacman_status"
fi  

if [ $pacman_status -eq 0 ] && [ $yay_status -eq 0 ]; then
	if [ "$update_status" == "" ]; then
		notify-send "No updates occoured"
	else
		notify-send "Updates occoured" "$update_status updated $total_packages packages"
	fi
fi
