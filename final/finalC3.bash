#!/bin/bash


input="report.txt"
output="report.html"
dest="/var/www/html/$output"
 
cat <<END > "$output"
<html>
<head>
	<title> Access logs w IOC</title>
	<style>
		body { background-color: #fff2fa; }
		table, th, td { border: 1px solid black; border-collapse: collapse; }
		th, td { padding: 5px; font-size: 17px;
	</style>
</head>
<body>
<h2> Access logs with IOC indicators:</h2>
<table>
END

while read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	datetime=$(echo "$line" | awk '{print $2}')
	ind=$(echo "$line" | awk '{print $3}')
	echo "<tr><td>$ip</td><td>$datetime</td><td>$ind</td></tr>" >> "$output"
done < "$input"

cat <<END >> "$output"
</table>
</body>
<html>
END

sudo mv "$output" "$dest"

echo "HTML file made and is now in $dest"
