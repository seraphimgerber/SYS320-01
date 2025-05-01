#!/bin/bash

{
	echo "<html><body><body style='background-color:#fff2fa;'><h2>Access logs with IOC indicators:</h2><table border='1'>"
	echo "<tr><th>IP address</td><th>Date and Time</th><th>Page Accessed</th></tr>"

	while read -r line; do
		ip=$(echo "$line" | awk '{print $1}')
		datetime=$(echo "$line" | awk '{print $2}')
		page=$(echo "$line" | awk '{print $3}')
		echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>"
	done < report.txt
	echo "</table></body></html>"
} > report.html

sudo mv report.html /var/www/html
echo "Report has moved to /var/www/html/report.html!"
