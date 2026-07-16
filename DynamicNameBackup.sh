# You are responsible for the backup strategy of a critical application configuration. The previous engineer used a static filename (backup.tar.gz) for the daily backup, causing each new backup to overwrite the previous day's data. This has led to a complete loss of historical data.

# Your goal is to implement a timestamped archiving strategy that preserves history by creating unique filenames for every run.

# Task
# Create a script named daily_archive.sh in /home/user/ that archives the application configuration.

# Note : user@123!

# 1. Configuration
# Define the following variables to ensure the script is portable:

# Target: /var/app/config (The directory to back up).
# Destination: /backup/daily (Where the archive will be stored).
# 2. Dynamic Naming Logic
# The script must generate a filename that changes automatically based on the date of execution.

# Format: The filename must strictly follow the pattern: app_YYYYMMDD.tar.gz.
# Example: If executed on October 25, 2025, the file must be named app_20251025.tar.gz.
# 3. Archive Creation
# Create a compressed archive (gzip) of the Target directory.
# Save the resulting file in the Destination directory using the dynamic name generated above.
# Ensure the script handles the creation of the destination directory if it does not already exist.
# Expected Outcome
# A new compressed archive is created in /backup/daily/ every time the script runs.
# The filename reflects the current date, ensuring previous backups are not overwritten.
# DevOps Lab
# Stop Lab


#!/bin/bash
Target="/var/app/config"
Destination="/backup/daily"
Date="$(date +%Y%m%d)"
[ -d "$Destination" ] || sudo mkdir -p "$Destination"
tar -czf "$Destination/app_$Date.tar.gz" "$Target"
echo "Backup Created $Destination/app_$Date.tar.gz"