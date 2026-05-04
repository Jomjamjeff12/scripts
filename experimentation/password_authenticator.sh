#!/usr/bin/env bash

password_1=""
password_2="hi"


read -p "new account or sign in (n/s): " request
if [ "$request" = "n" ]; then
	read -p "new username: " new_username
	touch ~/accounts/"$new_username"-credentials
	while [ "$password_1" != "$password_2" ]; do
		read -p "new password: " password_1
		read -p "repeat password: " password_2
		if [ "$password_1" != "$password_2" ]; then
			echo "passwords did not match"
		fi
	done
	echo "$password_1" \
        | argon2 7d6e1fc827f47307c27953bc83448eaf \
        -id -t 5 -k 300000 -p 1 \
        | grep "Hash" | sed -n 's/.*Hash://p' \
	> ~/accounts/"$new_username"-credentials
elif [ "$request" = "s" ]; then
	read -p "account: " username
	read -p "password: " password
	password_hash="$(echo "$password" \
        	| argon2 7d6e1fc827f47307c27953bc83448eaf \
        	-id -t 5 -k 300000 -p 1 \
        	| grep "Hash" | sed -n 's/.*Hash://p')"
	if [ "$password_hash" = "$(cat ~/accounts/"$username"-credentials)" ]; then
		echo "password was correct"
	else
		echo "password was incorrect"
	fi
else
	echo "not an option lol"
fi






