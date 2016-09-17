#!/bin/bash

function createSysUser(){
  useradd $projectName
  if [ $? -ne 0 ]
    then return 1
  fi
  return 0
}

function createScriptPlace(){
  /bin/mkdir -p $SCRIPTS_FILE_PATH$projectName
  if [ $? -ne 0 ]
    then return 1
  fi
  
  return 0
}

function newProjectExecution(){
  createSysUser
  if [ $? -ne 0 ] 
    then return 1
  fi
  createScriptPlace
  if [ $? -ne 0 ] 
    then return 1
  fi
  setNewProject
  if [ $? -ne 0 ] 
    then return 1
  fi
  createGitProject
  if [ $? -ne 0 ] 
    then return 1
  fi
  return 0
}

function createScriptPlaceVerification(){
  if [ -d "$SCRIPTS_FILE_PATH$projectName" ]
    then
      message="The backup name you entered is exist"
      return 1
  elif [[ -z "$projectName" ]] 
    then
      message="The entered an empty name"
      return 1
  else
      return 0
  fi
}


function createSysUserVerification(){

  if id -u "$projectName" >/dev/null 2>&1; then
    message="The user name you entered is exist"
    return 1
  elif [[ -z "$projectName" ]] 
    then
      message="The entered an empty name"
      return 1
  else
    return 0
  fi
}

function newProjectVerification(){

  createSysUserVerification
  if [ $? -ne 0 ] 
    then return 1
  fi
  createGitProjectVerification
  if [ $? -ne 0 ] 
    then return 1
  fi
  createScriptPlaceVerification
  if [ $? -ne 0 ] 
    then return 1
  fi  
  status=$( checkProjectAvailability )
  if [[ $status != "Not Found" ]]
    then return 1
  fi
  
  return 0
}

function newProject(){
  read -p "Please enter project name " projectName
  newProjectVerification
  while [ $? -ne 0 ]
    do
      read -p "$message please enter project name " projectName
      newProjectVerification
  done
  newProjectExecution
  if [ $? -eq 0 ] 
    then 
      echo "The project $projectName has been successfully created"
      read -p "Do you want to create a backup point for this project
      1) Yes
      2) No
      " nextStep
      if [ $nextStep == 1 ]
	then addNewType
      elif [ $nextStep == 2 ]
	then echo "Good Bye" exit;
      fi    
  else   echo "The project $projectName not created"
  fi
}
