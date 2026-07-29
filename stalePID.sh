#!/bin/bash
PIDFILE="/home/user/data_processor.pid"
if [ -f  "$PIDFILE" ]; then
        OLDPID=$(cat "$PIDFILE" | tr -d '[:space:]')
        if [[ -n $OLDPID ]] && ps -p "$OLDPID" > /dev/null 2>&1; then
                echo "Service already running"
                exit 0
        else
                echo "Stale PID detected. Cleaning up..."
                rm -f "$PIDFILE"
        fi
fi
nohup sleep 300 > /dev/null 2>&1 &
newpid="$!"
echo "$newpid" > /home/user/data_processor.pid
echo "Service started with PID $newpid"
