#!/bin/sh
#Programed by Keen Wang
#This script is used to cat the tcp traffic packages between 11.131.50.82
#and 11.131.248.15, so that the logs can be used in the investigation of
#timeout issue which happened on this machine.

log=tcpdump.$(date +%y_%m_%d_%H_%M).log
output=capture.$(date +%y_%m_%d_%H_%M_%S)

tcpdump -i eth0 -w $output>> $log &
pid=$!
echo $pid

#start a endless loop
while true
do
#calculate the size of the log file
_logsize=$(echo $(du -sm $output|awk '{print $1}'))
#if log size is null, then default to 0.
logsize=${_logsize:-0}

#if logsize is great than 10M, then kill the tcpdump procss
#and re-initiate the log variable and start the tcpdump again.
if [ $logsize -gt 10 ]
  then
   kill -9 $pid
   mv $output ${output}.bak
   log=tcpdump.$(date +%y_%m_%d_%H_%M).log
   output=capture.$(date +%y_%m_%d_%H_%M_%S)
   tcpdump -i eth0 -w $output >> $log &
   pid=$!
   echo $pid
fi
sleep 1

#if the count of the log files are more than 100
#then kill the process in case there are too many
#log files and occupy the disk space.
if [ $(ls|grep capture|grep log|wc -l) -gt 100 ]
  then
   kill -9 $pid
   echo "log files have exceeded 100, tcpdump has been killed!" >> $log
   #if the log files exceeds 100, break the loop.
   break
fi
done
