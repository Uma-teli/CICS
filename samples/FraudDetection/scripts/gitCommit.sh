#!/bin/env sh

cd /u/wml/jenkinsPipeline/WMLzAppBuild/

git add .

git commit -m 'commit'

GIT_SSH_COMMAND="ssh -i /u/wml/jenkinsPipeline/id_rsa"
git push origin master 
