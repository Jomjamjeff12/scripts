#!/usr/bin/env bash
if [ "$1" = "-t" ]; then
  keyfile="desktop-to-thinkpad"
  dest_ip="100.95.223.54"

elif [ "$1" = "-d" ]; then
  keyfile="thinkpad-to-pc"
  dest_ip="100.93.247.32"

elif [ "$1" = "-p" ]; then
  keyfile="id_ed25519"
  dest_ip="100.118.65.57"

elif [ "$1" = "-h" ]; then
  echo "
  use: rsync-custom [device] [send/recieve] [source] [destination]
  device:       -t thinkpad
                -p pi
                -d desktop

  send/recieve: -s send
                -r recieve
  "
  exit 0
else
  echo "invalid arg 1"
  exit 1 
fi


if [ "$2" == "-r" ]; then
  rsync -avz -e "ssh -i ~/.ssh/$keyfile" \
    "will@$dest_ip:$3" \
    "$4"

elif [ "$2" == "-s" ]; then
  rsync -avz -e "ssh -i ~/.ssh/$keyfile" \
    "$3" \
    "will@$dest_ip:$4"
else
  echo "invalid arg 2"
  exit 1
fi


