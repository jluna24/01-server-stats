#!/bin/bash
## Get total of CPU usage
total_cpu_usage=$(top -b -n1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

## Get total of memory usage Free vs Used including percentage
total_mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
## Get total of disk usage Free vs Used including percentage
total_disk_usage=$(df -h | grep '/' -w | awk '{print $5}' | sed 's/%//g')

## Get top 5 process consuming CPU
top5_cpu_process=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)

## Get top 5 process consuming Memory
top5_mem_process=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6)

echo "Total CPU Usage: $total_cpu_usage%"
echo "Total Memory Usage: $total_mem_usage%"
echo "Total Disk Usage: $total_disk_usage%"
echo "Top 5 CPU Consuming Process: $top5_cpu_process"
echo "Top 5 Memory Consuming Process: $top5_mem_process"