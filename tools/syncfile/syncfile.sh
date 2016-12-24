#!/usr/bin/env bash

#----------------------help----------------------
usage="Usage: syncfile.sh hbase-env.sh "
# if no args specified, show usage
if [ $# -lt 1 ]; then
  echo ${usage}
  exit 1
fi

file_var=$1
current_bin_path="`dirname "$0"`"
cat /hadoopecosystem/hbase/conf/regionservers | while read machine
  do
    echo "-----synchronize configure file ${file_var} to ${machine} machine"
    scp -rC ${current_bin_path}/${file_var} ${machine}:${current_bin_path}/${file_var}
  done
