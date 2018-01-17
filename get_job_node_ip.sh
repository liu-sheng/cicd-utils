#!/bin/bash
# This script should be run in the zuul server

job_id=$1
if [ -z "$job_id" ];then
    echo 'please sepcify job id'
    exit 1
fi
line==$(grep "To git+ssh" /var/lib/zuul/builds/$job_id/work/logs/job-output.txt)
str=${line#*@}
echo ${str%//*}
