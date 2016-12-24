#!/usr/bin/env bash

#init hive external table partitions
#author:michael wang
#----------------------help----------------------
usage="Usage: sh  init_hive_partition.sh --db medusa --table medusa_detail --start 20161001 --end 20161031 --path /log/medusa/parquet --event_id detail"
# if no args specified, show usage
echo "parameter length is $#"
if [ $# -lt 12 ]; then
  echo ${usage}
  exit 1
fi

while (( "$#" )); do
case $1 in
    --db)
      db="$2"
      ;;
   --table)
      table="$2"
      ;;
   --start)
      start="$2"
      ;;
   --end)
      end="$2"
      ;;
   --path)
      path="$2"
      ;;
   --event_id)
      event_id="$2"
      ;;
   --help)
      echo ${usage};exit -1
      ;;
  esac
shift
done


#check if put right parameter
if [ -z ${db} ] || [ -z ${table} ] || [ -z ${start} ] || [ -z ${end} ] || [ -z ${path} ] || [ -z ${event_id} ];then
echo "please put right parameter"
echo ${usage};exit -1
fi

echo "db is ${db},table is ${table},start is ${start},end is ${end},path is ${path}"
#generate file for hive script
current_bin_path="`dirname "$0"`"
output_file=${current_bin_path}/init_partition_file.txt

start_date=`date -d "${start}" +%Y%m%d`
end_date=`date -d "+1 day ${end}" +%Y%m%d`
echo "start to add partitions for ${db}.${table},`date`"
echo "use ${db};"> ${output_file}
while [[ ${start_date} < ${end_date}  ]]
do
    echo "######## ${start_date} #########"
    echo "alter table ${table} add IF NOT EXISTS partition (day_p='${start_date}') location '${path}/${start_date}/${event_id}';" >> ${output_file}
    start_date=`date -d "+1 day ${start_date}" +%Y%m%d`
done
#use hive command to init partition
/hadoopecosystem/hive/bin/hive -f ${output_file}
echo "end to add partitions for ${db}.${table},`date`"