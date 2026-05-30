#!/usr/bin/env bash

if [ "$1" == "-f" ]; then
  rsync -avz -e "ssh -i ~/.ssh/desktop-to-thinkpad" \
    "will@100.95.223.54:$1" \
    "$2"
elif [ "$1" == "-t" ]; then
  rsync -avz -e "ssh -i ~/.ssh/desktop-to-thinkpad" \
    "$2" \
    "will@100.95.223.54:$1"


