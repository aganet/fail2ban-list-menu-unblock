# Fail2Ban IP Unban Script

This is a Bash script that allows you to easily unban IP addresses from Fail2Ban jails using a user-friendly interface powered by `whiptail`. It gathers a list of currently banned IP addresses across all active jails and presents them in a scrollable menu, making it easy to select and unban IPs from specific jails.

## Features

- Retrieves a list of all active Fail2Ban jails.
- Displays all banned IP addresses across jails.
- Presents the list in a scrollable menu using `whiptail`.
- Unbans the selected IP address from its corresponding jail.

## Prerequisites

Before using this script, make sure the following software is installed:

1. **Fail2Ban**: configured and working properly. The script interfaces with `fail2ban-client`.
2. **Whiptail**: Used to present the user interface for IP selection. Install is this package is not installed `sudo apt-get install whiptail`

## Usage 
Clone this repository or download the script to your system:
```bash
git clone https://github.com/aganet/fail2ban-list-menu-unblock.git
cd fail2ban-list-menu-unblock
chmod +x fail2ban-menu-unblock.sh
sudo ./fail2ban-menu-unblock.sh

```
