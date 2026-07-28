#!/bin/bash
set -x
backupPath="/var/app/backups/$(date '+%Y-%m-%d')"
find /var/app/logs/ -type f -name "*.log" -size +10k | while read file; do
        sudo mkdir -p "$backupPath"
        sudo mv  "$file" "$backupPath/$(basename "$file").bak"
done
