#!/bin/bash
# This tells Linux to run this script using the Bash shell
# This script checks SSH logs for failed login attempts and reports IP addresses that look suspicious

# ==============================
# Configuration Section
# ==============================
LOG_FILE="/var/log/auth.log" # This is the log file that stores authentication activity, and on many Linux systems, failed SSH logins appear here
THRESHOLD=5                  # This is the minimum number of failed attempts before we flag an IP, and if an IP has 5 or more failed attempts, we report it.

# ==============================
# Start Message
# ==============================
echo "Monitoring failed SSH login attempts..."  # Print a message so the user knows what the script is doing


# ==============================
# Find and Count Failed Attempts
# ==============================
grep "Failed password" "$LOG_FILE" | \ # grep searches the log file and keeps only lines that contain "Failed password"
                                       # These lines usually mean a failed SSH login attempt
                                       # The pipe sends the filtered output to the next command

awk '{print $(NF-3)}' | \              # awk processes each line of text
                                       # NF means the number of fields in the line
                                       # $(NF-3) selects the field that usually contains the IP address
                                       # This step extracts only the IP addresses from the log lines
                                       # \ continue this command on the next line.

sort | \      # sort puts the IP addresses in order, and this is required before using uniq -c
uniq -c | \   # uniq -c counts how many times each IP address appears, and it outputs: count IP
sort -nr | \  # sort -nr sorts the results by number in reverse order, and this puts the highest counts at the top

while read count ip; do  # This While loop reads each line from the previous output.
                         # Each line has two parts: the count and the IP address.
                         # It stores them into variables named count and ip.
    if [ "$count" -ge "$THRESHOLD" ]; then                            # Check if the number of failed attempts is greater than or equal to the threshold
        echo "Possible brute-force attack from $ip ($count attempts)" # Print a warning message for that IP
    fi                                                                # End of the if statement
    
done   # End of the while loop
