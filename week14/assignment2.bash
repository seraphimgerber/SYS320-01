#!/bin/bash

link="http://10.0.17.6/Assignment.html"

fullPage=$(curl -sL "$link")

output=$(echo "$fullPage" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of \
"//html//body//table[@id='temp']//tr | //html//body//table[@id='press']//tr")

data=$(echo "$output" | sed 's/<\/tr>/\n/g' | sed -e 's/&amp;//g' -e 's/<tr>//g' -e 's/<td[^>]*>//g' -e 's/<\/td>/;/g' \
-e 's/<[/\]\{0,1\}a[^>]*.//g' -e 's/<[/\]\{0,1\}nobr>//g' -e 's/^[ \t]*//;s/[ \t]*$//' -e '/^$/d' -e 's|&#13;||g' )

tempLines=()
pressLines=()
counter=0

while read -r line; do
	if [[ "$line" == *"Temprature;" || "$line" == *"Pressure;"* ]]; then
		continue
	fi
	if [[ $counter -lt 5 ]]; then
		tempLines+=("$line")
	else
		pressLines+=("${line}")
	fi
	((counter++))
done <<< "$data"

for i in "${!tempLines[@]}"; do
	tempVal=$(echo "${tempLines[$i]}" | cut -d';' -f1)
	datetime=$(echo "${tempLines[$i]}" | cut -d';' -f2)
	pressVal=$(echo "${pressLines[$i]}" | cut -d';' -f1)
	echo "$pressVal $tempVal $datetime"
done
