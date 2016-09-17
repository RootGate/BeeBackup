#!/bin/bash

function beeBackupStart(){
	
	read -p "Do you want to create a new project new backup point?
	1) New project
	2) New backup point
        --------------------
	" Action
  if [[ $Action == 1 ]]
    then newProject
  elif [[ $Action == 2 ]]
    then addNewType
  else
    echo "Wrong answer"; exit;
  fi
}
 