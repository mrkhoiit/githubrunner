#!/bin/bash

# save percentage of disk usage
PERCENT=$(df --output=pcent /dev/sda1 | grep -o '[0-9]\+')

# print disk usage including date and time
echo "[$(date +"%m-%d-%Y %T")] Current disk usage: ${PERCENT}%"

# clean all unused docker data if disk usage is greater than 70%
if [[ $PERCENT -gt 90 ]]
then
  # delete all except images with lable: delete=false
  docker system prune -af

  # print disk usage after cleaning up
  PERCENT_AFTER=$(df --output=pcent /dev/sda1 | grep -o '[0-9]\+')
  echo "[$(date +"%m-%d-%Y %T")] Disk usage: ${PERCENT}% --> ${PERCENT_AFTER}%"
fi