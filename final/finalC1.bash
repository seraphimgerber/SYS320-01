#!/bin/bash


link="http://10.0.17.6/IOC.html"
fullPage=$(curl -sL "$link")

pageHtml=$(echo "$fullPage" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of "//html//body//table//td")

page=$(echo "$pageHtml" | sed 's/<\/td>/\n/g' | sed 's/<td>//g' | sed -n '2~2!p')

echo "$page" > IOC.txt
