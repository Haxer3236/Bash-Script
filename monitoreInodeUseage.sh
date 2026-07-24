#!/bin/bash
Inode=$(df -i / | tail -1 |awk '{print $5}' | sed "s/%//")
fileCount=$(fine /var/log -type f 2>/dev/null | wc -l)
limit=80
if [ $Inode -gt $limit ]; then
        echo "CRITICAL: Inode usage at $Inode%"
        echo "High density detected in logs: $fileCount file"
elif [ $Inode -le $limit ]; then
        echo "OK: Inode usage is $Inode%"
        echo "Log density: $fileCount file"
fi
