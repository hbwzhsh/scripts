#!/usr/bin/env bash

#----------------------help----------------------
#this script is used to monitor the kylin

pro_num=`netstat -nltp|grep 7070|wc -l`

if [ ${pro_num} -lt 1 ]; then
  echo "need restart kylin."`date`
  sh /hadoop/kylin/bin/kylin.sh start
else
  echo "kylin is ok."
fi

#*/10 * * * * . /home/hadoop/.bash_profile;sh /hadoop/kylin/bin/kylin_monitor.sh >> /hadoop/kylin/logs/kylin_monitor.log 2>&1
