#!/bin/bash
# This tells Linux to run this script using the Bash shell
# This script removes old log files from a directory

# ==============================
# Configuration Section
# ==============================
LOG_DIR="/path/to/logs" # This is the directory that contains log files
DAYS=30                 # This sets how many days old a file must be before it is deleted
                        # In this case, files older than 30 days will be removed


# ==============================
# Remove Old Log Files
# ==============================
find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS -exec rm -f {} \;
# find searches inside the directory
# "$LOG_DIR" is the folder being searched
# -type f means only regular files not directories
# -name "*.log" means only files ending with .log
# -mtime +$DAYS means files modified more than 30 days ago
# -exec runs a command on each file found
# rm -f deletes the file
# {} represents the file found
# \; ends the -exec command

# ==============================
# Completion Message
# ==============================
echo "Work Completed." # Prints a message showing that the script finished running
