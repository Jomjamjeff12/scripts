#!/usr/bin/env bash 
# Prompt for SSH password
ssh_password="$(zenity --password --title "SSH Key Password")"

# Create temporary askpass script
askpass_script="$(mktemp)"
cat > "$askpass_script" <<EOF
#!/usr/bin/env bash
printf '%s\n' "$ssh_password"
EOF

chmod +x "$askpass_script"

# Use askpass for SCP and check if it worked

kitty --hold raspissh-main.sh "$askpass_script"

sudo rm "$askpass_script"
unset ssh_password
