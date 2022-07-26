#!/bin/bash

####################################### Task #########################################################################
### [] create backup script for some data folder                                                                     #
### [] this script should be able to work in different modes                                                         #
##### [] backups minutely (with miliseconds in the archive name): 2022-07-17-09:53:53.3332211.zip                    #
##### [] backups hourly (with just day-hour): 2022-07-17-09:53.zip                                                   #
##### [] backups daily: 2022-07-17.zip                                                                               #
### [] script should also include archive file list in the archive and some meta information                         #
### [ ] about the execution details (who, when and how)                                                              #
### [ ] script should be added in crontab                                                                            #              
### [ ] Please replace path to some files                                                                            #
######################################################################################################################
# BEFORE YOU TRYING TO RUN THE SCRIPT, PLEASE CHANGE THE ALL PATH TO YOURS WHERE COMMENT NEED THAT !!!!
# Updating and installing soft we need
echo "Checking and updating soft"
sleep 1
sudo apt install tree zip -y 
if sudo apt install tree zip -y >/dev/null ; then
     echo "" > /dev/null
else
     echo "Something go wrong. Please check the errors and try again"
     exit 
fi
# Read the mode of archivation and the folder in which we must save archive
MODE=$1               # Mode of archivation
PATH_FOLDER=$2        # Path to saving archive
# Create cron_schedule and archive name from mode which user select
case $MODE in
    "minutely")
        cron_schedule="*/1 * * * *"        
        archive_name=$(date +%Y-%m-%d-%T.%7N)
        ;;
    "hourly")
        cron_schedule="1 * * * *"
        archive_name=$(date +%Y-%m-%d-%H)
        ;;
    "daily")
        cron_schedule="0 20 * * *"
        archive_name=$(date +%Y-%m-%d)
        ;;
    *)
        echo "Sorry, you enter the wrong input. Try again"
        exit 1
        ;;
esac
# Checking the user or process who run this script
# shellcheck disable=SC2009
CRON=$(ps -ef | grep "/usr/sbin/CRON -f" | awk '{print $2}' | head -1)  # checking the PID of CRONjob
# shellcheck disable=SC2009
SCRIPT=$(ps -ef | grep "$0 $1" | awk '{print $3}' | head -1)            # checking the PPID the our running script
if [ "$CRON" -eq "$SCRIPT" ]; then 
      LAUNCHER="start from CRON"
else
      LAUNCHER="start from user"
fi
# Create file meta.txt and write some info to it
touch /home/kali/Pictures/meta.txt      # PLEASE CHANGE THE PATH TO YOURS 
{
whoami 
date 
echo "Mode: $MODE" 
echo "Launcher: $LAUNCHER"
echo "List of files:"
tree /home/kali/Pictures                # PLEASE CHANGE THE PATH TO YOURS 
} > /home/kali/Pictures/meta.txt        # PLEASE CHANGE THE PATH TO YOURS
# archivation 
echo "Adding files to zip archive"
sleep 1
zip "$PATH_FOLDER/$archive_name".zip -r "/home/kali/Pictures/meta.txt" "/home/kali/Pictures"  # PLEASE CHANGE THE PATH TO YOURS FILES WHICH YOU WANT ARCHIVE 
# Checking active crontab and if there is not job, add to CRON
if crontab -l | grep "$0" ; then  
    echo "Crontab have job. The cron job see above" 
else    
    sleep 1
    echo "Add job to crontab"
    echo "$cron_schedule /home/kali/Pictures/archivation.sh $1 $2" | crontab   # adding job to CRON. PLEASE CHANGE THE PATH TO YOURS PATH TO THE SCRIPT
fi
# Copying to remote server
scp "$PATH_FOLDER/$archive_name".zip vlad@192.168.10.11:/home/vlad/Pictures    # PLEASE CHANGE THE PATH TO YOURS
