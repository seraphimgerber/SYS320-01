#!/bin/bash

log_file="/home/champuser/SYS320-01/week13/fileaccesslog.txt"
timestamp=$(date "+%Y-%m-%d %I:%M:%S %p")
echo "File was accessed at $timestamp" >> "$log_file"

function logFile(){
 cat $log_file
}

echo "To: seraphim.gerber@mymail.champlain.edu" > email.txt
echo "Subject: File Access Log" >> email.txt
logFile >> email.txt
cat email.txt | ssmtp seraphim.gerber@mymail.champlain.edu
