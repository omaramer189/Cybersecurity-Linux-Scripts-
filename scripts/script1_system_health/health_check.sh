#!/bin/bash             # This lien tells the system to run this file using the Bash Shell and without it linux will not know which interpreter to use
                        

echo "==============================="    # echo here prints text, this line of equal signs  to organize the title
echo "     Report SUMMARY"	              # These three echos print a header for the report to be organized
echo "==============================="

# ==============================
# Hostname Section
# ==============================

echo "Hostname: $(hostname)"   #  echo here want to print the computer name 
				               # hostname is a command that returns the computer's name
			                   # $(hostname) runs that command and inserts its result inside echo
                               # So this line prints the word "Hostname:" followed by the actual machine name


# ==============================
# Uptime Section
# ==============================
echo "Uptime:"      # echo here prints the word Uptime:
uptime -p           # here shows us how long the system has been running
		            # -p means here pretty format, so it prints it in a readable way

# ==============================
# CPU Load Section
# ==============================
echo ""                                       # Prints an empty line to make the output easier to read
echo "CPU Load (1, 5, 15 min averages):"      # Prints a label to explain the numbers that will appear next
uptime | awk -F'load average:' '{ print $2 }'   
# uptime prints system running time and CPU load
# The | pipe output of uptime into another command.
# awk splits the line at the words “load average” which means it processes text that awk text processing tool
# -F sets "load average:" as the field separator
# { print $2 } prints only the part after that phrase, which will contain the CPU load averages.
# which gives us only the CPU load numbers


# ==============================
# Memory Usage Section
# ==============================
echo ""                 # Prints an empty line to make the output easier to read
echo "Memory Usage:"    # Prints a label for memory information.
free -h					# free shows how much memory is being used
						# -h means human readable format, like MB, GB, instead of large numbers 
						
# ==============================
# Disk Usage Section
# ==============================
echo ""  									# Prints an empty line to make the output easier to read 
echo "Disk Usage:"                          # Prints a label before disk information.
df -h --total | grep -E 'Filesystem|total'  
# df -h shows disk space usage in readable format
# --total adds a total line at the bottom
# The | sends output to grep
# grep filters the results and only shows lines that contain -E means either "Filesystem" or "total"


# ==============================
# Top Processes Section
# ==============================
echo ""										# Prints an empty line to make the output easier to read
echo "Top 5 Memory-Consuming Processes:"	# Prints a label before listing processes
ps aux --sort=-%mem | head -n 6
# ps aux here lists all running processes
# --sort=-%mem sorts them by memory usage from highest to lowest
# head -n 6 shows the first 6 lines
# One line is the header, and the next five are the top processes

# ==============================
# End of Report
# ==============================

echo ""									  # Prints an empty line to make the output easier to read 
echo "==============================="	  # Prints text, this line of equal signs  to organize the title
echo "Check complete."					  # Final message to show the script has finished running

