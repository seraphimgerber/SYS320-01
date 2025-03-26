#!/bin/bash

# List all the ips in the given network prefix

# /24 only

# Usage: bash IPList.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix ex: 10.0.17\n" && \
exit 1

for i in {1..254}
do
	ping -c 1 "$prefix.$i" | grep "bytes from" | \
	grep -oE "$prefix\.[0-9]+"
done
