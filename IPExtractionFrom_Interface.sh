# Scenario
# As a system administrator, you are building a dashboard that needs to display the current IP address of the server. However, standard networking commands output a lot of technical noise (MAC addresses, broadcast info, IPv6, etc.).

# Your task is to write a robust Bash script that acts as a filter. It must accept an interface name as an input and output only the clean IPv4 address for that interface, stripped of any subnet masks or extra text.

# Task
# Working directory: /home/user/network-lab/

# 1. Input Handling:

# Create a script named get_ip.sh.
# The script should accept one command-line argument for the interface name (e.g., wlan0).
# Constraint: If no argument is provided, the script must default to using eth0 automatically.
# 2. Extraction Logic:

# Execute the command to display network interface details.

# Filter the output to locate the line containing the IPv4 address information.

# Extract the specific field containing the IP address and subnet mask.

# Remove the subnet mask (the / and everything after it) to leave only the raw IP address.

# 3. Output Formatting:

# If an IP is successfully found, print it in the following format:
# Interface: <interface_name>
# IP Address: <ip_address>
# If no IP is found (e.g., the interface is down or doesn't exist), print:
# No IP found for <interface_name>
# Expected Outcome
# Running ./get_ip.sh (with no arguments) defaults to eth0.
# Running ./get_ip.sh lo extracts and prints 127.0.0.1.



#!/bin/bash
INTERFACE="${1:-eth0}"
IP=$(ip add show "$INTERFACE" | grep inet | awk '{print $2}' | cut -d'/' -f1)
if [ -n "$IP" ];then
        echo "Interface: $INTERFACE"
        echo "IP Address: $IP"
else
        echo "No IP found for $INTERFACE"
fi

