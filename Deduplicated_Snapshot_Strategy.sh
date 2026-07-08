# Scenario
# Your team needs to run daily backups of a large application. Storing 30 full copies of the same 100GB data is inefficient.

# You need to implement a Deduplicated Snapshot Strategy.

# If a file hasn't changed since the last backup, the new backup should simply Hard Link to the existing data on the disk (consuming 0 extra space).
# If a file has changed, it should be copied normally.
# Task
# Create a script named smart_backup.sh in /home/user/.

# 1. Input Arguments
# To avoid hardcoding paths (and permission errors), your script must accept two arguments:

# Argument 1: Source Directory (e.g., /home/user/app_data)
# Argument 2: Backup Root Directory (e.g., /home/user/snapshots)
# 2. Directory Naming (Crucial)
# Each backup must be created inside the Backup Root with a timestamped folder name. Format: backup_YYYY-MM-DD_HHMMSS

# Example: backup_2023-10-25_143000
# 3. Incremental Logic (Simplified & Clear)
# Check if a symbolic link named latest exists inside the Backup Root.

# latest always points to the most recent backup directory.
# If latest exists:

# Use the directory pointed to by latest as the reference.

# For each file in the Source Directory:

# Unchanged file → create a Hard Link in the new backup.

# New or changed file → copy it normally.

# If latest does not exist:

# This is the first backup.

# Perform a full copy of the Source Directory.

# 4. Pointer Update
# After the backup is complete, update the latest symbolic link to point to this new timestamped folder. Research around on how this can be implemented.

# Expected Outcome
# Space Efficiency: Unchanged files between backups must share the same Inode (Hard Linked).
# Structure:
# /home/user/snapshots/
# ├── backup_2023-01-01_100000/
# ├── backup_2023-01-02_100000/
# └── latest -> backup_2023-01-02_100000
# Note: Sudo Password=user@123!


#!/bin/bash
SOURCE="$1"
BACKUP="$2"
TM=$(date +%Y-%m-%d_%H%M%S)
if [ -z "$SOURCE" ] || [ -z "$BACKUP" ]; then
        echo "Usage: $0 <Source> <Backup>"
        exit 1
fi
NEWBACKUP_PATH="${BACKUP}/backup_${TM}"
LATEST_LINK="${BACKUP}/latest"

mkdir -p "$BACKUP"
if [ -L "$LATEST_LINK" ];then
        sudo rsync -a --link-dest="$LATEST_LINK" "$SOURCE/" "$NEWBACKUP_PATH/"
else
        sudo rsync -a "$SOURCE/" "$NEWBACKUP_PATH/"
fi
sudo ln -sfn "$(basename "$NEWBACKUP_PATH")" "$LATEST_LINK"
echo "Backup created at $NEWBACKUP_PATH"