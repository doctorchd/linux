#!/bin/bash

cd $GIT_HOME

git checkout master
git pull
git fetch

for branch in `git branch | grep -v "^\*"`; do

    echo "------------------------------"
    echo "branch: $branch"
    echo
    git checkout $branch
    git rebase origin/master
    diff_count=`git diff master`
    git checkout master

    if [ "XXX$diff_count" = "XXX" ]; then
        echo "branch $branch may be deleted"
        echo -n "want to delete? "
        read answ
        #echo "answ = $answ"
        if [ "$answ" = "y" ]; then
            git branch -d $branch
        else
            echo "not deleted"
        fi
    else
        echo
        echo "branch $branch not merged to master"
    fi

done
