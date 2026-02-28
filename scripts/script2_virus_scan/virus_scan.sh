#!/bin/bash  # This tells Linux to run this file using the Bash shell
             # This script scans a directory for viruses using ClamAV and logs all activity to a log file

                    
# ==============================
# Configuration Section
# ==============================
SCAN_DIR=${1:-/home}               
# We create a variable called SCAN_DIR
# $1 means the first argument given when running the script
# Example: ./virus_scan.sh /var
# If the user provides a directory, that directory is used
# If no argument is given, it defaults to /home
# This makes the script flexible and safe


LOG_FILE="/var/log/virus_scan.log" # Define the log file location, and all scan results will be saved here.
DATE=$(date +"%Y-%m-%d %H:%M:%S")  # date gets the current date and time and $( ) runs the command and stores its output



# ==============================
# Start Scan Log Header
# ==============================
echo "=====================================" | tee -a "$LOG_FILE"     # Prints a separator line and writes it to the log file
                                                                      # tee -a means append output to the log file
echo "Virus Scan Started: $DATE" | tee -a "$LOG_FILE"             # Prints the start time of the scan and logs it
echo "Scanning Directory: $SCAN_DIR" | tee -a "$LOG_FILE"         # Prints which directory is being scanned
echo "=====================================" | tee -a "$LOG_FILE" # Prints another separator line.


# ==============================
# Check If ClamAV Is Installed
# ==============================
if ! command -v clamscan &> /dev/null; then
# command -v checks if clamscan exists in the system
# &> /dev/null hides output
# ! means "if NOT found"
# So this means: if clamscan is not installed, run the next block

    echo "ClamAV is not installed. Install it with:" | tee -a "$LOG_FILE" # These lines print and log a message explaining how to install ClamAV
    echo "  sudo apt install clamav" | tee -a "$LOG_FILE"
    exit 1   #  Stop the script because the scan cannot continue without ClamAV
fi


# ==============================
# Update Virus Definitions
# ==============================
echo "Updating virus definitions..." | tee -a "$LOG_FILE" # Prints message before updating virus database
freshclam | tee -a "$LOG_FILE"                            # freshclam downloads the latest virus definitions
                                                          # This ensures the scan can detect the newest threats
                                                          # Output is also saved to the log file

# ==============================
# Run Virus Scan
# ==============================
echo "Running virus scan..." | tee -a "$LOG_FILE" # Prints message before starting scan
clamscan -r --infected --bell "$SCAN_DIR" | tee -a "$LOG_FILE"
# clamscan scans for viruses
# -r means recursive, so scans all subfolders
# --infected shows only infected files
# --bell makes a sound if a virus is found
# "$SCAN_DIR" is the directory being scanned
# tee logs the output


# ==============================
# End of Scan
# ==============================
echo "Scan complete." | tee -a "$LOG_FILE" # Prints and logs that the scan finished
echo "" | tee -a "$LOG_FILE"               # Adds a blank line to the log file for better readability
