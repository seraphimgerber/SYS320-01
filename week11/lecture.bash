#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function pageCount(){
allLogs=$(cat "$file" | cut -d' ' -f1,7 | tr -d "[" | sort | uniq -c )
}

pageCount
echo "$allLogs"
