#!/usr/bin/env bash
current_bin_path="`dirname "$0"`"
echo "current_bin_path is ${current_bin_path}"
cd ${current_bin_path}
ps -ef|grep filebeat_product.yml|grep -v grep|awk '{print $2}'|xargs kill  -15
