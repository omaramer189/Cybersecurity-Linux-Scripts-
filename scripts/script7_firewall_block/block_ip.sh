#!/bin/bash
# This tells Linux to run the script using the Bash shell
# This script blocks a specific IP address using iptables


# ==============================
# Check If IP Address Is Provided
# ==============================
if [ -z "$1" ]; then    # using if statment and -z checks if the first argument is empty 
                        # $1 is the first argument given when running the script
                        # If no IP address is provided, this condition becomes true
    echo "Usage: $0 <IP-address>"  # $0 is the name of this script
                                   # This prints instructions showing how to use it
    exit 1                         # Stop the script because an IP address is required
fi                                 # end the if statment 


# ==============================
# Store IP Address
# ==============================
IP="$1" # Save the first argument into a variable named IP, and this makes the script easier to read and manage


# ==============================
# Validate IP Address Format
# ==============================
if ! [[ $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
# [[ ]] is used for advanced condition testing
# =~ means match against a regular expression
# The pattern checks if the input looks like an IPv4 address
# ! means "if it does NOT match"

    echo "Invalid IP address format."  # Print an error message if the format is incorrect.
    exit 1                             # Stop the script because the IP format is not valid.
fi                                     # Ends the statement 


# ==============================
# Check If IP Is Already Blocked
# ==============================
if iptables -C INPUT -s "$IP" -j DROP 2>/dev/null; then
# iptables -C checks if a rule already exists
# INPUT refers to incoming traffic
# -s "$IP" specifies the source IP address
# -j DROP means block traffic from that IP
# 2>/dev/null hides error messages

    echo "IP $IP is already blocked."      # Inform the user that the IP is already blocked
else                                       # If the rule does not exist, this block runs
    iptables -A INPUT -s "$IP" -j DROP     # -A means add a new rule
                                           # This command blocks traffic coming from the given IP address

    echo "IP $IP has been blocked."        # Confirm that the IP was successfully blocked
fi                                         # End of the firewall check
