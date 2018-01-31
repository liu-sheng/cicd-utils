#!/bin/bash
job_id=$1
if [ -z "$job_id" ];then
    echo 'please sepcify job id'
    exit 1
fi
node_line=$(grep "$job_id" /var/log/zuul/zuul.log |grep "Execute job")
ip_line==$(grep "To git+ssh" /var/lib/zuul/builds/$job_id/work/logs/job-output.txt)

node_str=${node_line#*Node }
echo ${node_str%% [*}
ip_str=${ip_line#*@}
echo ${ip_str%//*}
