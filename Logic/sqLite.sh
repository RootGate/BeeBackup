#!/bin/bash

function getProjectID(){
  pID=`sqlite3 $DB_PATH " SELECT pID FROM projects WHERE pName = ""'$projectName'"`
  if [[ -z "$pID" ]]
    then echo "Not Found"
  else echo $pID
  fi
}

function getBackupPointIP(){
  pIP=`sqlite3 $DB_PATH " SELECT bpTypeIP FROM backupPoint WHERE pID = (SELECT pID FROM projects WHERE pName = '$projectName')"`
}

function getBackupPointPath(){
  pIPath=`sqlite3 $DB_PATH " SELECT bpTypePath FROM backupPoint WHERE pID = (SELECT pID FROM projects WHERE pName = '$projectName')"`
}

function getAllProjects(){

  pID=`sqlite3 $DB_PATH " SELECT pName FROM projects"`
  echo "$pID" | column  -t -o ' '
}

function setNewProject(){
  `sqlite3 $DB_PATH " INSERT INTO projects (pName) VALUES ('$projectName')"`
}

function delProject(){
  `sqlite3 $DB_PATH " DELETE FROM projects WHERE pName = ""'$projectName'"`
}

function checkProjectAvailability(){
  pID=`sqlite3 $DB_PATH " SELECT pID FROM projects WHERE pName = ""'$projectName'"`
  if [[ -z "$pID" ]]
    then echo "Not Found"
  else echo $pID
  fi
}

function setNewOneBackupPoint(){
  proID=$( getProjectID )
  if [[ $proID != "Not Found" && $newType == "" ]] 
    then message="Faild to add a new Backup point"
    return 1
  else 
  `sqlite3 $DB_PATH " INSERT INTO backupPoint (pID,bpType,bpTypeIP,bpTypePath) VALUES ('$proID','$newType','$TypeIP','$TypePath')"`
  fi
}
function setNewMiltiBackupPoint(){
  newType="WEB"
  setNewOneBackupPoint
  if [ $? -ne 0 ]
    then return 1
  fi
  newType="Database"
  setNewOneBackupPoint
  if [ $? -ne 0 ]
    then return 1
  fi
  newType="Email"
  setNewOneBackupPoint
  if [ $? -ne 0 ]
    then return 1
  fi
  
  return 0
}

function delBackupPoint(){
  `sqlite3 $DB_PATH " DELETE FROM backupPoint WHERE bpType = '$newType' AND pID = '$proID'"`
}

function checkBackupPointAvailability(){
  proID=$( checkProjectAvailability )
  if [[ $proID != "Not Found" &&  $newType != "" ]] 
    then 
      bpID=`sqlite3 $DB_PATH " SELECT bpID FROM backupPoint WHERE pID = '$proID' AND bpType = '$newType'"`
      if [[ -z "$bpID" ]]
	then echo "Not Found"
      else echo $bpID
      fi
  else message="No Backup point found"
   echo "Not Found"
  fi
}

function checkBackupMultiPointAvailability(){
  newType="WEB"
  if [[  $( checkBackupPointAvailability ) != "Not Found" ]]
    then return 1
  fi
  
  newType="Email"  
  if [[  $( checkBackupPointAvailability ) != "Not Found" ]]
    then return 1
  fi
  
  newType="Database"  
  if [[  $( checkBackupPointAvailability ) != "Not Found" ]]
    then return 1
  fi
  newType="ALL"
  return 0
}
