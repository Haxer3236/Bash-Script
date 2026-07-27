# Scenario
# A recent audit discovered that several "successful" backups were actually empty or corrupt files. Management has mandated a "Trust but Verify" policy.

# You need to create a verification tool that doesn't just check if a file exists, but actively attempts to restore the data into a sandbox environment to prove the backup is valid.

# Task
# Create a script named restore_check.sh in /home/user/.

# 1. Input Handling
# The script must accept the path to a backup archive as its first argument (e.g., ./restore_check.sh /backup/app.tar.gz).
# 2. The Sandbox Environment
# Create a temporary directory /tmp/restore_test to serve as a sandbox.

# Safety Check: Ensure this directory is empty (or cleaned) before starting the test.

# 3. Active Verification Logic
# Attempt to extract the contents of the backup archive into the sandbox directory.

# Failure Condition: If the extraction command fails (returns a non-zero exit code), the script must print the exact failure message defined below and exit with a non-zero status.

# Success Condition: If extraction succeeds, count the number of files recovered in the sandbox.

# If 0 files are found, report the backup as empty.

# If > 0 files are found, report the backup as verified with the file count.

# 4. Cleanup
# Regardless of success or failure, the script must remove the /tmp/restore_test directory before exiting to prevent temporary file accumulation.
# Expected Outcome
# Your script must output messages strictly matching the formats below for the automated tests to pass:

# If Backup is Valid: Output: Restore Verified: <count> files recovered (Example: Restore Verified: 3 files recovered)
# If Extraction Fails (Corrupt File): Output: Extraction Failed
# If Backup is Empty (0 files): Output: Error: Backup is empty
# Note: Sudo Password=user@123!


#!/bin/bash
#backupPath="$1"
tmpPath="/tmp/restore_test"
sudo mkdir -p "$tmpPath"
sudo rm -rf "$tmpPath"/*
sudo tar -xzf "$1" -C "$tmpPath" > /dev/null 2>&1
if [ "$?" -eq 0 ];then
        count=$(find "$tmpPath" -type f | wc -l)
        if [ $count -eq 0 ];then
                echo "Error: Backup is empty."
                sudo rm -rf "$tmpPath"
        elif [ $count -gt 0 ];then
                echo "Restore Verified: $count files recoverd"
                sudo rm -rf "$tmpPath"
        fi
else
        echo "Extraction Failed"
        sudo rm -rf "$tmpPath"
        exit 1
fi