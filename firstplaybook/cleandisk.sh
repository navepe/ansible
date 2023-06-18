#!/bin/bash

total_size=$(df -h /dev/nvme0n1p2 | awk 'NR==2 {gsub(/[^0-9.]/,"",$2); print $2}')
number=2
half_size=$(echo "scale=0; $total_size / $number" | bc -l)
current_usage=$(df -h /dev/nvme0n1p2 | awk 'NR==2 {gsub(/[^0-9.]/,"",$2); print $3}')

if [ "$current_usage" -gt "$half_size" ]; then
    echo "Disk usage is greater than half of the total disk space."
    echo "Removing files older than 2 days in /tmp/ directory..."
    
    find /tmp/ -type f -mtime +2 -exec rm {} \;
    
    echo "Files older than 2 days in /tmp/ directory have been removed."
else
    echo "Disk usage is not greater than half of the total disk space."
fi