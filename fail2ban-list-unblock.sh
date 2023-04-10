#!/bin/bash

jails=$(fail2ban-client status | awk '/Jail list:/ {gsub(",", ""); for(i=4; i<=NF; i++) printf "%s ", $i}')

for jail in $jails
do

    banned_ips=$(fail2ban-client status $jail | awk '/Banned IP list:/ {print $NF}')
    echo "Jail: $jail"
    echo "List of banned IPs:"
    echo "$banned_ips"
    echo ""

    read -p "Do you want to unban any IP address from $jail? (y/n) " unban

    if [ "$unban" = "y" ]; then
        read -p "Enter the IP address you want to unban: " ip
        fail2ban-client set $jail unbanip $ip
        echo "IP address $ip has been unbanned from $jail."
    fi
done
