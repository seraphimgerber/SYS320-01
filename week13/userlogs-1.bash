#! /bin/bash

authfile="/var/log/auth.log"
 
function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,3,12 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
 logline=$(cat "$authfile" | grep "failure")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,3,17)
 echo "$dateAndUser"
}
#function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
#}

echo "To: seraphim.gerber@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp seraphim.gerber@mymail.champlain.edu

echo "To: seraphim.gerber@mymail.champlain.edu" > emailform2.txt
echo "Subject: Failed Logins" >> emailform2.txt
getFailedLogins >> emailform2.txt
cat emailform2.txt | ssmtp seraphim.gerber@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email
