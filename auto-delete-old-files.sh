#!/bin/bash

# Backup storage directory 
target_directory=/var/logs

# Number of days to store the file
keep_day=30 

# Delete old files 
find $target_directory -mtime +$keep_day -delete