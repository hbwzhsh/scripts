#!/usr/bin/env bash

#----------------------help----------------------
#this script is used to monitor the filebeat not consume log ,when the number lower than 10/s
#we will restart the filebeat.
threshold=10
usage="Usage: sh monitor_filebeat_hang.sh [threshold/s ,like 10]"
# if no args specified, show usage
if [ $# -eq 1 ]; then
  threshold=$1
 if grep '^[[:digit:]]*$' <<< "${threshold}";then
   echo "${threshold} is number."
 else
   echo 'please input number'
   echo ${usage}
   exit 1
 fi
fi

FILE_NAME="/tmp/logstash_metrics.log"

really_consume_speed=`tail -1 ${FILE_NAME}|awk -F ',' '{print $1}'`
really_consume_speed=`echo ${really_consume_speed%.*}`
echo "threshold is ${threshold},really_consume_speed is ${really_consume_speed}"

if [ ${really_consume_speed} -lt ${threshold} ]; then
  echo "${really_consume_speed} less than ${threshold},need restart filebeat."
  sh /opt/filebeat/restart_filebeat.sh
else
  echo "filebeat is ok."
fi

