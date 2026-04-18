#!/usr/bin/bash

if [ "$(cat /tmp/login-cycle.txt)" == "" ]; then
        touch /tmp/login-cycle.txt
fi
if [ "$(cat /tmp/login-cycle.txt)" == "1" ]; then
        sudo echo "2" > /tmp/login-cycle.txt
elif [ "$(cat /tmp/login-cycle.txt)" == "2" ]; then
        sudo echo "3" > /tmp/login-cycle.txt
        sleep 1
        sudo echo "0" > /tmp/login-cycle.txt
else
        sudo echo "1" > /tmp/login-cycle.txt
        login.sh &
fi
