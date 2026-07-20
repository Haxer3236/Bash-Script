# Scenario
# As a DevOps engineer, you frequently need to verify which IP addresses are associated with a specific domain name to troubleshoot load balancers or DNS propagation. Running commands manually produces too much text to parse quickly.

# Your task is to create a script named resolve.sh that automates this. It must accept a domain name, query the DNS system for IPv4 (A records) only, and output a clean, bulleted list of the IP addresses found.

# Task
# Working directory: /home/user/network-lab/

# 1. Input Validation:

# The script must accept one argument (the domain name).
# If the argument is missing, print an error message and exit.
# 2. Resolution Logic:

# Use a standard DNS command-line tool to query the domain.
# Constraint: You must filter the output to extract only the IPv4 addresses (A records).
# Filtering: Ensure you exclude CNAME aliases, timing information, or headers. The output must strictly contain the IP addresses.
# 3. Output Formatting:

# Print a header: Resolving: <domain_name>
# If IPs are found, iterate through them and print each one with a hyphen:
# IPv4 addresses:
#   - 192.0.2.1
#   - 192.0.2.2
# If no IPs are found, print: No IPv4 addresses found.
# Expected Outcome
# Running ./resolve.sh example.com lists the correct IP address(es) cleanly.
# Running ./resolve.sh (no argument) shows an error.



#!/bin/bash
DNS=${1:? Error: Required the Argument}
IP=$(dig +short "$DNS" 2>/dev/null)
if [[ -n $IP ]];then
        echo "Resolving: $DNS"
        #IP=$(dig +short "$DNS")
        echo "IPv4 addresses:"
        for ip in $IP;do
                echo " - $ip"
        done
else
        echo "No IPv4 addresses found"
fi
