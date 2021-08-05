#!/bin/bash

# Backup storage directory 
backup_folder=/home/database-backups/backups

# Logs storage directory 
logs_folder=/home/database-backups/logs

# MySQL user
user=root

# MySQL password
password=secret

# Number of days to store the file 
keep_day=30 

sqlfile=$backup_folder/all-database-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backup_folder/all-database-$(date +%d-%m-%Y_%H-%M-%S).zip 

# Create a backup 
mysqldump -u $user -p$password --all-databases > $sqlfile 

if [ $? = 0 ]; then
  printf "$(date +%d-%m-%Y_%H-%M-%S): Sql dump created\n" >> $logs_folder/out.log
else
  printf "$(date +%d-%m-%Y_%H-%M-%S): mysqldump return non-zero code. No backup was created!\n" >> $logs_folder/error.log
  exit 
fi 

# Compress backup 
zip $zipfile $sqlfile 

if [ $? = 0 ]; then
  printf "$(date +%d-%m-%Y_%H-%M-%S): The backup was successfully compressed\n" >> $logs_folder/out.log
else
  printf "$(date +%d-%m-%Y_%H-%M-%S): Error compressing backup\n" >> $logs_folder/error.log
  exit 
fi 

rm $sqlfile

printf "$(date +%d-%m-%Y_%H-%M-%S): Backup was successfully created $zipfile\n" >> $logs_folder/out.log

# Delete old files 
find $backup_folder -mtime +$keep_day -delete
find $logs_folder -mtime +$keep_day -delete
