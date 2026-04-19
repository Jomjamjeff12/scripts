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

keyfile="$(mktemp)"

# Use askpass for SCP and check if it worked
if ! DISPLAY=:0 SSH_ASKPASS="$askpass_script" setsid -w \
                scp -i ~/.ssh/id_ed25519 \
                will@100.118.65.57:~/passwords/keyfile.key \
                "$keyfile"; then
        notify-send "SCP failed"
        shred -u "$keyfile"
        shred -u "$askpass_script"
        unset ssh_password
        echo "0" > /tmp/login-cycle.txt
        exit 1
fi

# Clean up askpass script
shred -u "$askpass_script"
unset ssh_password

# Prompt for KeePass database password
kp_pass="$(zenity --password --title "Database password")"

# Prompt for the username
username="$(zenity --entry --title "account username")"

# Get username from KeePass and check if it is valid
if ! account_username="$(printf "%s" "$kp_pass" | keepassxc-cli show \
                -a username \
                ~/passwords/Passwords.kdbx "$username" \
                --key-file "$keyfile")"; then
	notify-send "Database entry or password was incorrect"
        shred -u "$keyfile"
        echo "0" > /tmp/login-cycle.txt
        unset kp_pass
        exit 1
fi


# Copy username
wl-copy "$account_username"
notify-send "Username copied"

# Get password from KeePass
password="$(
        printf "%s" "$kp_pass" | keepassxc-cli show \
                -a password \
                ~/passwords/Passwords.kdbx "$username" \
                --key-file "$keyfile"
)"

# Wait for login cycle step 2
until [ "$(</tmp/login-cycle.txt)" == "2" ]; do
        sleep 1
done

wl-copy "$password"
notify-send "Password copied"
unset password

# Extract TOTP secret and generate code
totp_url="$(
        printf "%s" "$kp_pass" | keepassxc-cli show \
                -a otp \
                ~/passwords/Passwords.kdbx "$username" \
                --key-file "$keyfile" \
        | sed -n 's/.*secret=\([^&]*\).*/\1/p'
)"
totp="$(oathtool --totp -b "$totp_url")"

# Wait for login cycle step 3
until [ "$(</tmp/login-cycle.txt)" == "3" ]; do
        sleep 1
done

wl-copy "$totp"

unset totp totp_url
shred -u "$keyfile"

notify-send "TOTP copied and data secured"
