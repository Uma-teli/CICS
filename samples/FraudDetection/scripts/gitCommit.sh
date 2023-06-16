#!/bin/env sh

cd /u/wml/jenkinsPipeline/WMLzAppBuild/

git add .

git commit -m 'commit'

git push origin master 'root:ibmuser@7'
