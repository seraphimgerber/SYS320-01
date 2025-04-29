link="http://10.0.17.6/Assignment.html"

fullpage=$(curl -sL "$link")

table=$(echo "$fullPage" | sed -n '/<table/,/<\/table>/p' | sed 's/<[^>]*>//g')
split=$(echo "$table" | grep -n "Pressure" | cut -d ':' -f 1)

temp=$(echo "$table" | head -n $((split - 1)) | sed '/^$/d')

temp2=($(echo "$temp" | sed 's/[[:space:]]*$//'))


press=$(echo "$table" | tail -n +$split | sed '/^$/d')

press2=($(echo "$press" | sed 's/[[:space:]]*$//'))


time=($(echo "$press" | sed -n '/Time/,$p' | sed 's/[[:space:]]*$//'))

for ((i = 2; i < "${#time[@]}"; i+=2)); do
	echo "${temp2[$i]} - ${press2[$i]} - time[$i]}"
done
