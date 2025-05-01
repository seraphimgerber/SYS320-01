#!/bin/bash


if [ "$#" -ne 2 ]; then
	echo "Needs access_log and ioc_file input"
	exit
fi

access_log=$1
ioc=$2

: > report.txt

grep -f "$ioc" "$access_log" | cut -d' ' -f1,4,7 | tr -d '[' >> report.txt
