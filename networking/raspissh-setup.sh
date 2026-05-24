#!/usr/bin/env bash 
# Prompt for SSH password
ssh_password="$(zenity --password --title "SSH Key Password")"

# Create temporary askpass script and make it executable
askpass_script="$(mktemp)"
cat > "$askpass_script" <<EOF
#!/usr/bin/env bash
printf '%s\n' "$ssh_password"
EOF
chmod +x "$askpass_script"

# Use askpass for SSH
kitty --hold raspissh-main.sh "$askpass_script" &

# wait for login to finalise
sleep 5

# remove all sensitive info
shred -u "$askpass_script"
unset ssh_password
