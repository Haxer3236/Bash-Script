# Scenario
# You need to verify if a critical server is online and measure its responsiveness. Manually running ping and interpreting the results every time is tedious.

# Your task is to create a script named check_host.sh that accepts a hostname or IP address as an argument. It must attempt to contact the host and provide a clean "Reachable" or "Unreachable" status report, including the average latency if successful.

# Task
# Working directory: /home/user/network-lab/

# 1. Input Validation:

# The script must accept one argument (hostname/IP).
# If the argument is missing, the script should print an error message and exit.
# 2. Connectivity Logic:

# Use the ping command to test connectivity.
# Constraint: Limit the test to exactly 3 packets and set a timeout to prevent the script from hanging on bad hosts.
# Suppress the raw output of the ping command so it doesn't clutter the terminal.
# 3. Latency Extraction:

# If the host is reachable, you must extract the Average Latency from the ping statistics.
# Hint: The last line of ping output typically contains this data.
# 4. Output Formatting:

# If Reachable: Print:
# <host> is reachable
# Average latency: Xms
# If Unreachable: Print: <host> is unreachable Exit with a non-zero status.
# Expected Outcome
# Running ./check_host.sh google.com outputs:
# google.com is reachable
# Average latency: 2.303ms
# Running ./check_host.sh (without arguments) prints an error.


#!/bin/bash
HOST=${1:? ERROR: Hostname Required}
if ping -c 3 -W 2 "$HOST" &>/dev/null;then
        echo "$HOST is reachable"
        avg=$(ping -c 3 -W 2 "$HOST" | tail -1 | awk '{print $4}' | cut -d'/' -f2)
        echo "Average latency: ${avg}ms"
        exit 0
else
        echo "$HOST is unreachable"
        exit 1
fi
~           