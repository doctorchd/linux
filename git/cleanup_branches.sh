#!/bin/bash

set -e

cur_branch=`git status -bs | sed "{s/^## //;s/\..*//;}"`
cur_dir=`pwd`
pushd $cur_dir

cd $FWD_BASE_DIR
status=`git status -s`

if [ "XXX$status" != "XXX" ]; then
    echo "$status"; echo; echo "Cannot proceed"
    cd $cur_dir; exit 1
fi

git checkout master; git pull; git fetch

for branch in `git branch | grep -v "^\*"`; do
        git checkout $branch > /dev/null 2>&1
        git rebase origin/master > /dev/null

    diff_master=`git diff master`
    git checkout master > /dev/null 2>&1

    if [ "XXX$diff_master" = "XXX" ]; then
        echo
        echo "$branch may be deleted" | grep --color $branch
        echo -n "want to delete? "; read answ
        if [ "$answ" = "y" ]; then
            git branch -d $branch; echo
            if [ "$branch" = "$cur_branch" ]; then
                cur_branch="master"
                return_to_master=1
                #cur_dir=$FWD_BASE_DIR
            fi
        else
            echo "not deleted"
        fi
    else
        echo "$branch not merged to master" | \
            grep --color $branch
    fi
done

git checkout $cur_branch
cd $FWD_BASE_DIR
if ! $return_to_master ; then
    popd
fi

