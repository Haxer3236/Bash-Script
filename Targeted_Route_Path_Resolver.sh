# Scenario
# get the gateway , interface, source form this scrip with giving only the ip address

# In a complex production environment with multiple network interfaces (e.g., distinct VPNs, public vs. private LANs), simply knowing the "Default Gateway" isn't enough. You need to know exactly which path traffic will take to reach a specific destination IP.

# Your task is to create a utility script named route_audit.sh that queries the kernel's routing table to determine the Gateway, Interface, and Source IP used to reach a user-provided target.

# Task
# Working directory: /home/user/network-lab/

# 1. Input Validation:

# The script must accept exactly one argument: <TARGET_IP>.
# If missing, exit with code 1.
# 2. Routing Logic:

# Do not just read the static routing table (ip route show). You must use the kernel's route resolver command (ip route get <IP>) to see exactly how the OS handles that specific IP.

# Parsing Complexity: The script must handle two distinct scenarios:

# Scenario A (Remote): Traffic goes through a Gateway (contains keyword via).

# Scenario B (Local): Traffic is on the local LAN (no gateway, direct link).

# 3. Output Format (Strict):

# The output must be a single pipe-delimited line:
# Target: <IP> | Gateway: <GW_IP_OR_DIRECT> | Interface: <IFACE> | Source: <SRC_IP>
# Note: If the traffic is direct (no via), set the Gateway value to "Direct Link".
# Expected Outcome
# Case 1 (Google DNS): ./route_audit.sh 8.8.8.8 Output:
# Target: 8.8.8.8 | Gateway: 192.168.1.1 | Interface: eth0 | Source: 192.168.1.50
# Case 2 (Local LAN): ./route_audit.sh 192.168.1.50 Output:
# Target: 192.168.1.50 | Gateway: Direct Link | Interface: eth0 | Source: 192.168.1.50



!/bin/bash
TARGET="${1:? Error: Target IP required}"
raw=$(ip route get "$TARGET" | head -n 1)
if echo "$raw" | grep -q "via";then
        GT=$(echo "$raw" | awk '{for(i=1;i<=NF;i++) if($i=="via") print $(i+1)}')
else
        GT="Direct Link"
fi
IFC=$(echo "$raw" | awk '{for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}')
SRC=$(echo "$raw" | awk '{for(i=1;i<=NF;i++) if($i=="via") print $(i+1)}')
echo "Target: $TARGET | Gateway: $GT | Interface: $IFC | Source: $SRC"
