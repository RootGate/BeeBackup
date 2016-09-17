#!/bin/bash
 
function addRsyncCronJob(){
 x=3
}

function addRsyncScript(){
  touch $projectName file.sh
  echo " rsync -av –delete -e 'ssh -p 12345' -i    root@192.168.75.190:/home/$projectName home  .   >> /home/logs/bee.log"  >  $projectName file.sh
}

function startRsync(){
  getBackupPointIP
  getBackupPointPath
  cd "/home/"$projectName"/WEB"
  if [[ -z "$pIP" && -z $pIPath ]] 
    then echo "Not working"
    else `rsync -av --delete -e 'ssh -i $authKeyPath' $connectionUserName@$pIP:$pIPath` .  #   >> /home/logs/bee.log
    newGitCommit
  fi
}

function createNewRsyncExecution(){
  #addRsyncScript
  startRsync
}

function createNewRsyncVerfication(){
#  if [ -f  "$projectName file.sh" ]
#  then
#    ptint message
#  elif
    x="new one"
#  fi 
}


function createNewRsync(){
 #createNewRsyncVerfication
 createNewRsyncExecution
 prepareCronJobLine
}
