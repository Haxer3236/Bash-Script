# Scenario
# Maya has set up a shared directory /var/app/uploads where users drop data files. Currently, she has to manually check this folder every hour to move new files to the processing server. This is inefficient.

# She needs a Real-Time Watcher that instantly detects when a new file arrives and processes it immediately.

# You must implement a daemon-like script that watches a specific directory. When a file is Created, the script must print a status message and Move the file to a processed directory.

# Task
# Create a script named file_watcher.sh in /home/user/.

# 1. Setup
# Define the following directories at the start of the script:

# Watch Directory: /var/app/uploads
# Destination Directory: /var/app/processed
# Safety: Ensure both directories exist. If they don't, create them automatically.
# 2. Monitoring Logic
# Implement a loop that continuously monitors the Watch Directory.

# Event: The logic should trigger specifically when a new file is detected (e.g., data.txt).
# 3. Processing Action
# When a new file is detected:

# Print a timestamped message: [<Timestamp>] New file detected: <filename>
# Move the file immediately to the Destination Directory.
# Print: Moved to processed.
# Expected Outcome
# When you run the script in the background and create a file in the upload folder, your script should output:

# [Mon Oct 25 10:00:01 UTC 2025] New file detected: test.txt
# Moved to processed.



#!/bin/bash
watchdir="/var/app/uploads"
dest="/var/app/processed"
[ -d "$watchdir" ] || sudo mkdir -p "$watchdir"
[ -d "$dest" ] || sudo mkdir -p "$dest"
inotifywait -m "$watchdir" -e close_write --format '%w%f' | while read newfile;do
        #ls "$watchdir"
        #sleep 5
        echo "[$(date)] New file detected: $newfile"
        mv "$newfile" "$dest/"
        echo "Moved to processed."
done
~                                                          
~                