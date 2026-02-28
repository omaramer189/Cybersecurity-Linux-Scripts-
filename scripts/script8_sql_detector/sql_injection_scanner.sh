#!/bin/bash  
# This tells Linux to run the script using the Bash shell.
# This script scans input text for possible SQL injection patterns.


# ==============================
# Input Section
# ==============================
if [ -n "$1" ]; then # -n checks if the first argument is NOT empty, and if the user provides a file name, this condition becomes true.
    INPUT=$(cat "$1")  # cat reads the content of the file and $( ) runs the command and stores its output inside the variable INPUT.
else                # If no file is provided, this block runs.
    INPUT=$(cat)    # cat without a file reads from standard input (keyboard or pipe).
fi                  # End of input selection.


# ==============================
# Define SQL Injection Patterns
# ==============================
PATTERNS=(
    "'[[:space:]]*or[[:space:]]+1=1"      # This detects patterns like: ' OR 1=1 with different spacing
    "'[[:space:]]*or[[:space:]]+'1'='1"   # This detects patterns like: ' OR '1'='1
    "union[[:space:]]+select"             # Detects UNION SELECT statements
    "select[[:space:]]+.*from"            # Detects SELECT ... FROM queries
    "insert[[:space:]]+into"              # Detects INSERT INTO statements
    "drop[[:space:]]+table"               # Detects DROP TABLE statements
    "--"                                  # Detects SQL comment marker used to ignore the rest of a query
    ";--"                                 # Detects another common SQL injection ending
    "xp_cmdshell"                         # Detects dangerous SQL Server commands often used in attacks
    "information_schema"                  # Detects database structure queries often used by attackers
)

FOUND=0   # Create a variable named FOUND and 0 means no suspicious pattern has been found yet

# ==============================
# Start Scanning
# ==============================
echo "Scanning for patterns..."                   # Print a message so the user knows the scan is starting
echo "----------------------------------------"   # Print a separator line
for pattern in "${PATTERNS[@]}"; do                      # This loop goes through each pattern inside the PATTERNS array
    if echo "$INPUT" | grep -Eiq "$pattern"; then        # echo sends the input text to grep
                                                         # -E allows extended regular expressions
                                                         # -i ignores uppercase and lowercase differences
                                                         # -q runs quietly and only returns true or false
                                                         # If the pattern is found, this condition becomes true
        echo "[WARNING] Possible SQL injection pattern detected: $pattern"  # Print a warning message showing which pattern was detected                                                           
        FOUND=1                                                             # Change FOUND to 1 because something suspicious was found
    fi                                                                      # End of pattern check
done                                                                        # End of loop


# ==============================
# Final Result
# ==============================
if [ "$FOUND" -eq 0 ]; then  # if statement and -eq compares numbers. If FOUND is still 0, then nothing suspicious was detected
    echo "No obvious SQL injection patterns detected."      # Print safe result
else                                                        # else 
    echo "Potential SQL injection detected!"                # Print warning result if at least one pattern was found
fi                                                          # End of final check
