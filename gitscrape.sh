#!/bin/bash

# A helpful script to parse git logs of a single contributor 
# across multiple projects using git.
# make sure you set the folders to wherever you house your
# viscira git project repos.
#
# a) create file called gitscrape in usr/local/bin
# b) chmod 755 gitscrape
# c) $$$
#
# using:
# go to any folder that you want to store csvs
# run this:
#     gitscrape Mario
# gitscrapes my Mario's contribution to any of the repos in your project folder.

# VARIABLES: Change these variables for your workspace
function gitscrape() {
TIMELOGS=$HOME/Desktop/code/viscira

WORKSPACE=$HOME/Desktop/code/viscira
echo $1;
AUTHOR="$1"
AFTER_DATE='2020-10-11 00:00:00'

PROJLOG=$(pwd)/${AUTHOR}_project-log_$(date +"%Y-%m-%d").csv

touch $PROJLOG

# READ LOGS, OUTPUT CSV

# -- find directories with Git
GITDIRS=$(find $WORKSPACE -name .git -print0 | xargs -0 -n1 dirname | sort --unique)

# -- create the cvs to view
echo "project,timestamp,desc" > $TMPLOG
for proj in $GITDIRS ; do
   # go into the project folder, run git fetch to make sure you have logs
   cd $proj
   pwd
   git fetch
   
   # git log out from date
   git log --after="$AFTER_DATE"  --author="$AUTHOR" --pretty=format:"$proj,%ai,%f" >> $PROJLOG
   # alternate log since option
   # git log ---since='last 2 months' --author="$AUTHOR" --pretty=format:"$proj,%ai,%f" >> $TMPLOG
   echo "" >> $PROJLOG
   cd ..
done


}
if (test $(baseName "$0") == "gitscrape");
  then
    gitscrape "$@"
fi
