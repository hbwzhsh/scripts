#!/usr/bin/env bash
export LANG=zh_CN.UTF-8

function DataNodeIsExist
 {
    . /home/hadoop/.bash_profile
    pro_num=`jps|jps -ml|grep org.apache.hadoop.hdfs.server.datanode.DataNode|wc -l`
    if [ ${pro_num} -gt 0 ]
    then
    {
        echo "1"
    }
    else
    {
       echo "0"
    }
    fi
 }
