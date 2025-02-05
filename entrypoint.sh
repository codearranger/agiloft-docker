#!/bin/bash

# Function to gracefully shutdown Agiloft
shutdown() {
    echo "Received termination signal, stopping Agiloft..."
    /usr/local/Agiloft/bin/ew-control -a stop -v
    exit 0
}

# Trap SIGTERM and SIGINT signals
trap shutdown SIGTERM SIGINT

# Start Agiloft
echo "Starting Agiloft..."
/usr/local/Agiloft/bin/ew-control -a start -v

# Keep container running
while true; do
    sleep 1
done
