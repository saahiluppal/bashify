#!/bin/bash
date
echo "Uptime:"
uptime
echo "Currently Connected:"
w
echo "--------------------"
echo "Last Logins:"
last -a | head -3
echo "--------------------"
echo "Disk and Memory Usage:"
df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
echo "--------------------"
start_log=$(head -1 /var/log/messages | cut -c 1-12)
oom=$(grep -ci kill /var/log/messages)
echo -n "OOM errors since $start_log :" $oom
echo ""
echo "--------------------"
echo "Utilization and Most Expensive Processes:"
top -b | head -3
echo
top -b | head -10 | tail -4
echo "--------------------"
echo "Open TCP ports:"
nmap -p -T4 127.0.0.1
echo "--------------------"
echo "Current connections:"
ss -s
echo "--------------------"
echo "Processes:"
ps auxf --width=200
echo "--------------------"
echo "Vmstat:"
vmstat 1 5
