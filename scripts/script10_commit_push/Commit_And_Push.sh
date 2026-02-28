#!/bin/bash
# This tells Linux to run this file using the Bash shell
# This script adds changes, commits them, and pushes them to a specific Git branch

# Usage:
# ./script10.sh /path/to/git/repo "Commit message" branch_name

# ==============================
# Stop Script If Any Error Happens
# ==============================
set -e # set -e means if any command fails, stop the script immediately and prevent the script from continuing if something goes wrong


# ==============================
# Store Arguments
# ==============================
TARGET_REPO="$1"    # $1 is the first argument and should be the path to the Git repository
COMMIT_MESSAGE="$2" # $2 is the second argument, and this is the commit message that will be used
BRANCH_NAME="$3"    # $3 is the third argument, and this is the branch name where we will push the changes


# ==============================
# Check If All Required Arguments Are Provided
# ==============================
if [ -z "$TARGET_REPO" ] || [ -z "$COMMIT_MESSAGE" ] || [ -z "$BRANCH_NAME" ]; then  # -z checks if a variable is empty
                                                                                     # || means OR
                                                                                     # If any of the three arguments is missing, this condition becomes true
    echo "Usage: $0 <git_repo_path> <commit_message> <branch_name>"     # $0 is the script name
                                                                        # This prints instructions showing how to run the script correctly
    exit 1                                                              # Stop the script because all three arguments are required
fi                                                                      # End of argument check


# ==============================
# Check If Target Is a Valid Git Repository
# ==============================
if [ ! -d "$TARGET_REPO/.git" ]; then   # -d checks if a directory exists
                                        # .git is the hidden folder inside every Git repository
                                        # ! means NOT
                                        # If the .git folder does not exist, it is not a valid Git repository
    echo "Target is not a valid git repository."  # Print error message
    exit 1                                        # Stop the script because we cannot run git commands here
fi                                                # End of repository validation


# ==============================
# Move Into Repository Directory
# ==============================
cd "$TARGET_REPO" # Change directory into the target repository, and all git commands will now run inside this folder


# ==============================
# Add All Changes
# ==============================
echo "Adding changes..."  # Inform the user that files are being staged
git add -A                # git add -A stages all changes, including new, modified, and deleted files


# ==============================
# Commit Changes
# ==============================
echo "Committing..."                                          # Inform the user that the commit process is starting
git commit -m "$COMMIT_MESSAGE" || echo "Nothing to commit."  # git commit creates a new commit with the provided message
                                                              # If there are no changes to commit, git returns an error
                                                              # || means OR
                                                              # If commit fails, print "Nothing to commit." instead of stopping the script


# ==============================
# Push to GitHub
# ==============================
echo "Pushing to GitHub..."      # Inform the user that the push is starting
git push origin "$BRANCH_NAME"   # git push sends the commits to GitHub
                                 # origin is the default remote repository
                                 # "$BRANCH_NAME" is the branch we are pushing to

# ==============================
# Completion Message
# ==============================
echo "Push complete." # Final message showing that everything finished successfully
