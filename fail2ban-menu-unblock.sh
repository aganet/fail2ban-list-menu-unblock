#!/bin/bash

if ! command -v whiptail &> /dev/null; then
    echo "whiptail could not be found. Please install it to use this script."
    exit 1
fi

ip_menu=""
declare -A ip_to_jail

jails=$(fail2ban-client status | awk '/Jail list:/ {gsub(",", ""); for(i=4; i<=NF; i++) print $i}')

for jail in $jails; do
    banned_ips=$(fail2ban-client status "$jail" | awk '/Banned IP list:/ {for (i=4; i<=NF; i++) print $i}')
    
    if [ -n "$banned_ips" ]; then
        while read -r ip; do
            if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                ip_menu+="$ip $jail "
                ip_to_jail["$ip"]="$jail"
            fi
        done <<< "$banned_ips"
    fi
done

echo "$ip_menu"

if [ -z "$ip_menu" ]; then
    echo "No banned IPs found in any jail."
    exit 0
fi

selected_ip=$(whiptail --title "Unban IP Address" --menu "Select an IP address to unban:" 20 78 10 $ip_menu 3>&1 1>&2 2>&3)

if [ -n "$selected_ip" ]; then
    jail="${ip_to_jail[$selected_ip]}"
    
    if [ -z "$jail" ]; then
        echo "Error: Jail is empty. Please check the script and input data."
        exit 1
    fi

    fail2ban-client set "$jail" unbanip "$selected_ip" && echo "IP address $selected_ip has been unbanned from jail $jail." || echo "Failed to unban IP address $selected_ip from jail $jail."
else
    echo "No IP address selected."
fi
