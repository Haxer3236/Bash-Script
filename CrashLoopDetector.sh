#!/bin/bash
set -x
CMD=$1
MIN=1
MAX=3
if [ -z "$1"]; then
        exit 1
fi
while [ $MIN -le $MAX ]; do
        $CMD
        if [ $? -eq 0 ]; then
                echo "Service finished successfully."
                exit 0
         else
                echo "Service crashed. Retrying..."
                sleep 1
                ((MIN=$MIN+1))
        fi
done
if [ $MIN -gt $MAX ]; then
        echo "Max retries reached. Giving up."
        exit 1
fi
                        