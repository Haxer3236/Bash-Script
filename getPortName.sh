#!/bin/bash
#$(ss -tnlp 2>/dev/null | grep "LISTEN" | while read -r line);do
#       process=$(echo "$line" | awk '{print $6}' | cut -d'"' -f2)
#       port=$(echo "$line" | awk '{print $4}' | cut -d':' -f2)
#done;
process=$(ss -tlnp 2>/dev/null | grep "LISTEN" | awk '{print $6}' | {cut -d'"' -f2} || echo "unknown")
port=$(ss -tlnp 2>/dev/null | grep "LISTEN" | awk '{print $4}' | cut -d':' -f2)
printf "%-8s %s\n" "$port" "$process"
~                                       