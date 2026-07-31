#!/bin/bash
WATCH_DIR="/var/app/uploads"
DEST_DIR="/var/app/processed"
mkdir -p "$WATCH_DIR"
mkdir -p "$DEST_DIR"
if command -v inotifywait &> /dev/null; then
  inotifywait -m -e create "$WATCH_DIR" --format "%f" | while read FILENAME; do
    echo "[$(date)] New file detected: $FILENAME"
    mv "$WATCH_DIR/$FILENAME" "$DEST_DIR/$FILENAME"
    echo "Moved to processed."
  done
else
  while true; do
    if [ "$(ls -A $WATCH_DIR)" ]; then
      for FILE in "$WATCH_DIR"/*; do
        [ -e "$FILE" ] || continue
        FILENAME=$(basename "$FILE")
        echo "[$(date)] New file detected: $FILENAME"
        mv "$FILE" "$DEST_DIR/$FILENAME"
        echo "Moved to processed."
      done
    fi
    sleep 1
  done
fi