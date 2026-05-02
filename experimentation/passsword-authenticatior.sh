#!/usr/bin/env bash

# Creates argon2 hash from stdin sourced from zenity and a ~300 bit entropy salt and extracts the hash
password_hash="$(
	zenity --password --title "password" \
	| argon2 7d6e1fce427d3ecb2ffe4e6f6c30e9dc1263c827f47307c27953bc83448eaf75 \
	-t 15 -k 30000 -p 5 \
	| grep "Hash" | sed -n 's/.*Hash://p'
)"

# Notifies it was correct, for this example, the compared hash is for "hello"
if [ "$password_hash" = "		d112b2dec738236f15e5ca9ac3b7f8c7fae4c5e9fa61820ea6a0cd023032a35f" ]; then
	notify-send "password was correct"

else
	notify-send "password was incorrect"
fi

