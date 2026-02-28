#!/bin/bash
# This tells Linux to run this file using the Bash shell.
# This script automatically adds and commits changes inside a Git repository

# ==============================
# Stop Script If Any Error Happens
# ==============================
set -e # set -e means if any command fails, stop the script immediately. This makes the script safer and prevents partial execution


# ==============================
# Store Arguments
# ==============================
TARGET_REPO="$1"      # $1 is the first argument given when running the script, and this should be the path to the Git repository
COMMIT_MESSAGE="$2"   # $2 is the second argument and this should be the commit message we want to use


# ==============================
# Check If Required Arguments Are Provided
# ==============================
if [ -z "$TARGET_REPO" ] || [ -z "$COMMIT_MESSAGE" ]; then # -z checks if a variable is empty
                                                           # || means OR
                                                           # If either the repository path or the commit message is missing, this condition becomes true
    echo "Usage: $0 <git_repo_path> <commit_message>"      # $0 is the name of the script, and this prints instructions showing how to correctly run the script
    exit 1                                                 # Stop the script because both arguments are required
fi                                                         # End of argument check


# ==============================
# Check If Target Is a Valid Git Repository
# ==============================
if [ ! -d "$TARGET_REPO/.git" ]; then   # -d checks if a directory exists
                                        # .git is the hidden folder that makes a directory a Git repository
                                        # ! means NOT
                                        # If the .git folder does not exist, then it is not a valid Git repository

    echo "Target is not a valid git repository."   # Print error message
    exit 1                                         # Stop the script because we cannot run git commands here
fi                                                 # End of repository validation


# ==============================
# Move Into Repository Directory
# ==============================
cd "$TARGET_REPO"  # cd changes the current directory to the target repository
                   # All git commands will now run inside this folder


# ==============================
# Add All Changes
# ==============================
echo "Adding changes to git..." # Print a message to inform the user
git add -A                      # git add -A stages all changes, including new, modified, and deleted files


# ==============================
# Commit Changes
# ==============================
echo "Committing..."             # Inform the user that the commit process is starting
git commit -m "$COMMIT_MESSAGE"  # git commit creates a new commit
                                 # -m allows us to provide the commit message directly
                                 # "$COMMIT_MESSAGE" contains the message provided by the user


# ==============================
# Completion Message
# ==============================
echo "Done."  # Print a final message showing the script finished successfully
