#!/usr/bin/env bash

pkill -9 keepassxc
sleep 1
sudo scp -i /mnt/usb/ssh/id_ed25519 /mnt/usb/passwords/Passwords.kdbx will@100.118.65.57:~/passwords/
sudo systemctl stop mnt-usb.automount mnt-usb.mount
sudo cryptsetup close usb-luks 2>/dev/null
sudo bash -c 'echo 3 > /proc/sys/vm/drop_caches'
sudo systemctl start mnt-usb.automount
notify-send "Safe to unplug"

