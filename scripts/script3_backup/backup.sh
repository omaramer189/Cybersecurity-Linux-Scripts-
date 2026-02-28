#!/bin/bash
# This tells Linux to run this file using the Bash shell
# This script creates a compressed backup of a directory

# ==============================
# Configuration Section
# ==============================
SOURCE_DIR="/path/to/source"  # This is the directory we want to back up
BACKUP_DIR="/path/to/backups" # This is the directory where the backup file will be saved

# ==============================
# Create Timestamp
# ==============================
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
# The date command gets the current date and time
# $( ) runs the command and stores its output
# The format makes the timestamp look like: 2026-03-01_14-35-20
# This helps us create unique backup file names

# ==============================
# Define Backup File Name
# ==============================
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
# This creates the full path and name of the backup file.
# It combines:
# - the backup folder
# - the word "backup"
# - the timestamp
# - the .tar.gz extension


# ==============================
# Create the Backup
# ==============================
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"
# tar is used to archive files
# -c means create a new archive
# -z means compress using gzip
# -f means specify the file name
# "$BACKUP_FILE" is the output archive file
# "$SOURCE_DIR" is the directory being backed up

# ==============================
# Completion Message
# ==============================
echo "Work Completed: $BACKUP_FILE" # Prints a message showing where the backup file was saved

