#!/bin/bash             # This lien tells the system to run this file using the Bash Shell and without it linux will not know which interpreter to use
                        

echo "==============================="    # echo here prints text, this line of equal signs  to organize the title
echo "     Report SUMMARY"	              # These three echos print a header for the report to be organized
echo "==============================="

# Hostname
echo "Hostname: $(hostname)"   #  echo here want to print the computer name 
				                       # hostname is a command that returns the computer's name
			                         # $(hostname) runs that command and inserts its result inside echo
                              # So this line prints the word "Hostname:" followed by the actual machine name
                    
echo "Uptime:"      # echo here prints the word Uptime:
uptime -p           # here shows us how long the system has been running
		                # -p means here pretty format, so it prints it in a readable way

echo ""                                       # Prints an empty line to make the output easier to read
echo "CPU Load (1, 5, 15 min averages):"      # Prints a label to explain the numbers that will appear next


uptime | awk -F'load average:' '{ print $2 }'   
# uptime prints system running time and CPU load
# The | pipe output of uptime into another command.
# awk splits the line at the words “load average” which means it processes text that awk text processing tool
# -F sets "load average:" as the field separator
# { print $2 } prints only the part after that phrase, which will contain the CPU load averages.



echo ""                 # echo here prints an empty line for spacing
echo "Memory Usage:"    
free -h

echo ""
echo "Disk Usage:"
df -h --total | grep -E 'Filesystem|total'

echo ""
echo "Top 5 Memory-Consuming Processes:"
ps aux --sort=-%mem | head -n 6

echo ""
echo "==============================="
echo "Check complete."

