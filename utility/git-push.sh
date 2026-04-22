#!/usr/bin/env bash

git add .

read -p "commit message: " message

git commit -m "$message"

GIT_SSH_COMMAND='ssh -i ~/.ssh/git-key' git push
