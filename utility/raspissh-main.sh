#!/usr/bin/env bash

DISPLAY=:0 SSH_ASKPASS="$1" \
	setsid -w \
	ssh -i ~/.ssh/id_ed25519 \
	will@100.118.65.57
