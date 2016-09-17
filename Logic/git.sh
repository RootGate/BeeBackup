#!/bin/bash

function createGitProject(){

gitFeedback=`curl -s -X POST  -H "Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" -F "name=$projectName" 'http://'$gitServerIP'/api/v3/projects?private_token='$gitUserToken'' | jq '.id' >/dev/null `

if [ "$gitFeedback" != "null" ]
    then 
	initGitProject
    else
#        echo "The project $projectName is exist"
	return 1
fi

return 0
}

function initGitProject(){
#useradd $projectName
projectHome="/home/"$projectName 

git config --global user.name $gitUserName
git config --global user.email $gitUserEmail

eval `ssh-agent -s`
ssh-add /home/bee/.ssh/id_rsa
#echo $projectHome
cd $projectHome

git init
#touch README.md
#git add README.md
#git commit -m "first commit"
#git remote add origin git@gitlab.beebackup.com:root/"$projectName".git
#git push -u origin master

}

 
function newGitCommit(){
projectHome="/home/"$projectName 

git config --global user.name $gitUserName
git config --global user.email $gitUserEmail

eval `ssh-agent -s`
ssh-add /home/bee/.ssh/id_rsa

#git add -A is equivalent to  git add .; git add -u.
#
#git add . is that it looks at the working tree and adds all those paths to the staged changes if they are either changed or are new and not ignored, it does not stage any 'rm' actions.
#
#git add -u looks at all the already tracked files and stages the changes to those files if they are different or if they have been removed. It does not add any new files, it only stages changes to already tracked files.

cd $projectHome
git add -A
git commit -m "$projectName - `date`"
git remote add origin git@gitlab.beebackup.com:root/"$projectName".git
git push -u origin master

}


function listGitProjects(){
curl -s -X GET  'http://192.168.75.242/api/v3/projects/all?private_token=PZet5g38A7opYsng66en' | jq '.[].name' | column  -t -o '' >/dev/null 
}


function createGitProjectVerification(){

listGitProjects | grep \"$projectName\"

  if [ $? -eq 0 ]
    then 
#    message="The user name you entered is exist" 
    return 0
  fi
  
  return 0
}
#createGitProjectVerification

#createGitProject

#initGitProject

#newGitCommit
