#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

repo=$1
remote=$2
remoteURL=$3

### Clean repo first
miniOneLifeCompile/ensureClean.sh $repo

### Add remote if not exist
git -C $repo remote show $remote > /dev/null 2>&1 && exit 0 || git -C $repo remote add $remote $remoteURL
git -C $repo fetch $remote

### Track all branches of this remote 
for remoteBranch in `git -C $repo branch -r | grep $remote/ | grep -v /HEAD`; do 
    if [[ "$remote" == "origin" ]]; then
        git -C $repo checkout --track $remoteBranch
    else
        git -C $repo checkout -b "${remoteBranch////_}" --track $remoteBranch
    fi
done

### Find out the default branch of a remote and check it out
prefix="${remote}_"
if [[ "$remote" == "origin" ]]; then prefix=""; fi
branchName=`git -C $repo remote show $remote | sed -n '/HEAD branch/s/.*: //p'`
branchName="${prefix}${branchName}"
git -C $repo checkout $branchName