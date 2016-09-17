#!/bin/bash
# set variables 

#System variables Setup
declare -r CURRENT=`pwd`
declare -r DB_PATH=$CURRENT"/DB/beeDB"
declare -r GIT_LOGIC=$CURRENT"/Logic/git.sh"
declare -r PROJECTS_LOGIC=$CURRENT"/Logic/projects.sh"
declare -r BACKUP_POINTS_LOGIC=$CURRENT"/Logic/backupPoints.sh"
declare -r SQLLITE_LOGIC=$CURRENT"/Logic/sqLite.sh"
declare -r START_LOGIC=$CURRENT"/Logic/start.sh"
declare -r RSYNC_LOGIC=$CURRENT"/Logic/rSync.sh"
declare -r SCRIPT_LOGIC=$CURRENT"/Logic/genScripts.sh"
declare -r SCRIPTS_FILE_PATH=$CURRENT"/scripts/"
declare -r CRONJOBS_FILE_PATH=$CURRENT"/Logic/cronJobs.sh"

#Message Color variables Setup
declare -r __Warning="/log/"
declare -r __Success="\033[40;37m"
declare -r __Error="/log/"

#GIT variables Setup
declare -r gitServerIP="192.168.75.242"
declare -r gitUserToken="PZet5g38A7opYsng66en"
declare -r gitUserName="beeBackup"
declare -r gitUserEmail="abubakr.ramadan@code95.com"
declare -r gitBranch="master"
declare -r gitRepo="git@gitlab.beebackup.com:root"

#CronJob variables Setup
declare -r CRONJOBS_SETUP_FILE_PATH=$CURRENT"/CronJobs/beeCrons.sh"

declare -r __TWICE_A_DAY__="* */12 * * *"
declare -r __ONCE_A_DAY__="10 8 * * *"
declare -r __TWICE_A_WEEK__="10 8 * * 6,4"
declare -r __ONCE_A_WEEK__="10 8 * * 6"
declare -r __ONCE_A_MONTH__="10 8 15 * *"

#rsync variables
declare -r authKeyPath=$CURRENT"/Key/id_rsa"
declare -r connectionUserName="root"

#Welcome message
banner "-=bee backup=-"

#Locd project
. $SQLLITE_LOGIC
. $RSYNC_LOGIC
. $CRONJOBS_FILE_PATH
. $SCRIPT_LOGIC
. $BACKUP_POINTS_LOGIC
. $PROJECTS_LOGIC
. $GIT_LOGIC
. $START_LOGIC
