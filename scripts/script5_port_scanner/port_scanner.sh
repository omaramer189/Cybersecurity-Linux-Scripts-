#!/bin/bash
# This tells Linux to run the script using the Bash shell
# This script scans ports 1 to 1024 on a target IP address


# ==============================
# Configuration Section
# ==============================
TARGET=$1     # $1 is the first argument given when running the script, and it should be the target IP address
START_PORT=1  # This is the first port number to scan
END_PORT=1024 # This is the last port number to scan
              # Ports 1–1024 are called well-known ports


# ==============================
# Check If Target Is Provided
# ==============================
if [ -z "$TARGET" ]; then        # -z checks if the variable is empty, and if no IP address is provided, this condition becomes true.
    echo "Usage: $0 <target-ip>" # $0 is the script name, and this prints instructions on how to use the script.
    exit 1                       # Stop the script because a target is required.
fi                               # End of the if statement.


# ==============================
# Start Port Scanning
# ==============================
echo "Working please be patient..."                   # Inform the user that the scan is starting
for ((port=$START_PORT; port<=$END_PORT; port++)); do # This is a for loop and starts at START_PORT and increases by 1 each time
                                                      # It continues until it reaches END_PORT
    timeout 1 bash -c "echo >/dev/tcp/$TARGET/$port" 2>/dev/null \
        && echo "Port $port is OPEN"
# timeout 1 means stop the connection attempt after 1 second
# bash -c runs a command inside Bash
# /dev/tcp is a special Bash feature that tries to open a TCP connection
# If the connection succeeds, the port is open
# 2>/dev/null hides error messages
# && means "if the previous command succeeds"
# If the port is open, print that it is OPEN
done      # finished the loop


# ==============================
# Completion Message
# ==============================
echo "Work complete."    # Print message when scanning is finished.
