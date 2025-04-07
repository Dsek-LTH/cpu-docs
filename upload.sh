#! /bin/bash

# Date in format Day-Month-Year
date=$(date +"%Y-%m-%d %T")
status_file='run_info/status.txt'

# Commit message
message="Backup for $date"
git add .
git commit -m"${message}"
status="$(git status --branch --porcelain)"
echo $status >> $status_file
if [ "$status" == "## main...origin/main" ]; then
  echo "IT IS CLEAN" >> $status_file
else
  echo "There is stuff to push" >> $status_file
  git push -u origin main
fi