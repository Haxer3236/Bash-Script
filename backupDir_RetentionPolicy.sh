

# The backup drive is filling up rapidly. The auditors have introduced a "Tiered Retention Policy" to balance storage costs with data safety. Instead of keeping every backup forever on the expensive high-speed disk, data must migrate through storage tiers based on its age.

# You need to write a maintenance script that enforces this lifecycle automatically.

# Task
# Create a script named tiered_cleanup.sh in /home/user/.

# 1. Configuration
# Hot Storage: /backup/hot (For recent backups).
# Cold Storage: /backup/cold (For long-term archival).
# 2. Tier 1: Archival (Hot to Cold)
# Identify backup archives in the Hot Storage that are older than 3 days.
# Move these files to the Cold Storage directory.
# Constraint: The file must be removed from Hot Storage after being successfully moved to Cold Storage.
# 3. Tier 2: Expiration (Cold to Delete)
# Identify backup archives in the Cold Storage that are older than 10 days.
# Permanently delete these files to free up space.
# Expected Outcome
# When the script is executed:

# Files older than 3 days disappear from /backup/hot and appear in /backup/cold.
# Files older than 10 days in /backup/cold are completely removed from the system


#!/bin/bash
hotstorage="/backup/hot"
coldstorage="/backup/cold"
hotfile="$(find "$hotstorage" -type f -mtime +3)"
coldfile="$(find "$coldstorage" -type f -mtime +10)"
if [ "$hotfile" ];then
        mv "$hotfile" "$coldstorage/"
fi
if [ "$coldfile" ];then
        rm -f "$coldfile"
fi