#!/usr/bin/bash

if [ "$(cat /tmp/login-cycle.txt)" == "" ]; then
	touch /tmp/login-cycle.txt
fi
if [ "$(cat /tmp/login-cycle.txt)" == "1" ]; then
	echo "2" > /tmp/login-cycle.txt
elif [ "$(cat /tmp/login-cycle.txt)" == "2" ]; then
	echo "3" > /tmp/login-cycle.txt
	sleep 1
	 echo "0" > /tmp/login-cycle.txt
else
         echo "1" > /tmp/login-cycle.txt
        login-main.sh &
fi
