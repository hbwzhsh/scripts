#!/usr/bin/env bash
current_bin_path="`dirname "$0"`"
echo "current_bin_path is ${current_bin_path}"
cd ${current_bin_path}
sh /opt/filebeat/stop_filebeat.sh
sleep 10s

pro_num=`ps -ef|grep filebeat_product.yml|grep -v grep|wc -l`
echo "pro_num is $pro_num"
if [ ${pro_num} -gt 0 ]; then
  echo "filebeat is already exist,no need to restart"
  exit 1
else
echo "start filebeat...."
sh /opt/filebeat/start_filebeat.sh
fi
