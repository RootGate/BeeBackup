#!/bin/bash

function AddNewOneType(){
#  /bin/mkdir -p "/backup/$projectName/$newType"
#  if [ $? -ne 0 ]
#    then return 1
#  fi
  
  /bin/mkdir -p "/home/$projectName/$newType"
  if [ $? -ne 0 ]
    then return 1
  fi
  
  setNewOneBackupPoint
  if [ $? -ne 0 ]
    then return 1
  fi
  
  return 0
}

function IPValidiation(){

  ipcalc -c -4 $TypeIP
  if [ $? -ne 0 ]
    then return 1
  fi
  
  return 0
}

function GetNewTypeIP(){

while [[ -z "$TypeIP" ]] 
    do
      read -p "Please enter Source IP address " TypeIP
      IPValidiation
      if [ $? -ne 0 ]
	TypeIP=""
	read -p "Please enter a valid Source IP address " TypeIP
	then return 1
      fi
  done
  return 0
}

function GetNewTypePath(){

while [[ -z "$TypePath" ]] 
    do
      read -p "Please enter Source Path " TypePath
  done
}

function GetNewTypeScheduler(){
x=3
}

function AddNewMultiTypes(){
#  /bin/mkdir -p "/backup/$projectName/"{WEB,Database,Mail}
#  if [ $? -ne 0 ]
#    then return 1
#  fi
  
  /bin/mkdir -p "/home/$projectName/"{WEB,Database,Mail}
  if [ $? -ne 0 ]
    then return 1
  fi
  
  setNewMiltiBackupPoint
  if [ $? -ne 0 ]
    then return 1
  fi
  
  return 0
}

function addNewTypeExecution(){

  if [ $newType == "ALL" ]
    then AddNewMultiTypes
  else AddNewOneType
  fi
  
  if [ $? -ne 0 ]
    then return 1
  fi
  createNewRsync
  scriptCreation
  return 0
}

function addNewTypeVerification(){
  if [[ $bpType -gt 0 && $bpType -lt 4 ]]
    then
      if [ -d "/home/$projectName/$newType" ]
	then return 1
#      elif [ -d "/home/$projectName/$newType" ]
#	then return 1
      elif [[  $( checkBackupPointAvailability ) != "Not Found" ]]
	then return 1
      fi
  else 
#      if [ -d "/backup/$projectName/WEB" ]
#	then return 1
#      elif [ -d "/backup/$projectName/Email" ]
#	then return 1
#      elif [ -d "/backup/$projectName/Database" ]
#	then return 1
      if [ -d "/home/$projectName/WEB" ]
	then return 1
      elif [ -d "/home/$projectName/Email" ]
	then return 1
      elif [ -d "/home/$projectName/Database" ]
	then return 1
      fi
      checkBackupMultiPointAvailability
      if [ $? -ne 0 ] 
	then  return 1
      fi
  fi  
  
  return 0  
}

function addNewType(){

  while [[ -z "$projectName" ]] 
    do
      read -p "Please enter project name " projectName
      newProjectVerification
      if [ $? -eq 0 ] 
	then
	  projectName=""
	  echo "The entered project name does not exist
	  "
      fi
  done
  
  read -p "Please select a backup point type?
  1) Web
  2) Database
  3) Email
  4) All
    --------------------
  " bpType
  
  if [ $bpType == 1 ]
    then newType="WEB"
  elif [ $bpType == 2 ]
    then newType="Database"
  elif [ $bpType == 3 ]
    then newType="Email"
  elif [ $bpType == 4 ]
    then newType="ALL"
  else echo "Wrong answer"; exit;
  fi
  
  GetNewTypeIP
  GetNewTypePath
  addNewTypeVerification
  if [ $? -eq 0 ]
    then addNewTypeExecution
	  if [ $? -eq 0 ]
	      then echo "The backup has been successfully created"
	  else echo "The backup point faild to create"
	  fi
  else echo -e "The Backup point $__Success $newType \033[0m for project $__Success $projectName \033[0m is exist"
  fi
}
