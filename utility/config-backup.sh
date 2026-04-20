#!/usr/bin/bash

notify-send "Backup started"
rsync -av --delete /etc/ /mnt/usb/backups/thinkpad/etc
rsync -av --delete ~/.config /mnt/usb/backups/thinkpad/.config
rsync -av --delete ~/.bashrc /mnt/usb/backups/thinkpad/.bashrc

notify-send "Backup complete"
