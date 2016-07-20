#!/bin/sh
# 检查nagios日志中是否有短信发送错误
#
NAGIOS_LOG=/usr/local/nagios/var/nagios.log
NOTIFY_SMS=/usr/local/nagios/libexec/notify_bysms_op.sh

#检查nagios日志是否存在短信发送异常
if [ -f $NAGIOS_LOG ]
  then
    timestamp=$(grep "timed out after 30 seconds" $NAGIOS_LOG|awk -F "]" '{print $1}' \
      |awk -F "[" '{print $2}'|tail -1)
    timestamp=${timestamp:=0}
     if [ $timestamp -gt $(( $(date +%s) - 600 )) ]
       then
         $NOTIFY_SMS "NAGIOS短信发送异常，请检查nagios.log"
         service nagios restart
     fi
  else
    $NOTIFY_SMS "NAGIOS日志不存在，请检查"
fi

NAGIOS_PID=$(ps -ef|grep nagios.cfg|awk '{ if ($3 == 1) {print $2}}')

if [ x"$NAGIOS_PID" = "x" ]
  then
    $NOTIFY_SMS "NAGIOS进程不存在，请检查"
fi 
