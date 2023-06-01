#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."

### Help message to use this script
helpmsg() {
	echo "Options to build: "
	echo "  thol        - client, server and editor"
	echo "  tholHetuw   - client"
	echo "  townplanner - editor"
	echo "  ohol        - client, server and editor"
	echo "  oholHetuw   - client"
	echo "  origin"
}

if [[ "$1" == "" ]]; then 
	helpmsg
    exit 1
fi

### Ensure all repos are clean before checking out
dirty=0
for repo in OneLife OneLifeData7 minorGems; do
    if [[ -n "$(git -C $repo status --porcelain)" ]]; then
        echo "$repo contains modified or untracked files"
        dirty=1
    fi
done

if [ "$dirty" -ne 0 ]; then
    read -p "Discard all changes? (y/n)" reply
    if [[ "$reply" == "y" ]]; then
        for repo in OneLife OneLifeData7 minorGems; do
            git -C $repo clean -f -x -d;
            git -C $repo checkout -- .
        done
    else
        echo "Abort"
        exit 1
    fi
fi

### Function to add remote and track its branches
addRemoteAndTrackBranches() {
    local repo=$1
    local remote=$2
    local remoteURL=$3
    
    ### Add remote if not exist
    git -C $repo remote show $remote > /dev/null 2>&1 && return 0 || git -C $repo remote add $remote $remoteURL
    git -C $repo fetch $remote
    
    ### Track all branches of this remote 
    for remoteBranch in `git -C $repo branch -r | grep $remote/ | grep -v /HEAD`; do 
        git -C $repo checkout -b "${remoteBranch////_}" --track $remoteBranch; 
    done
}


### Get the correct remotes given the option
repo_option="$1"

if [[ "$repo_option" == "thol" ]]; then
    addRemoteAndTrackBranches OneLife thol "https://github.com/twohoursonelife/OneLife.git"
    addRemoteAndTrackBranches OneLifeData7 thol "https://github.com/twohoursonelife/OneLifeData7.git"
    addRemoteAndTrackBranches minorGems thol "https://github.com/twohoursonelife/minorGems.git"
    git -C OneLife checkout thol_master
    git -C OneLifeData7 checkout thol_master
    git -C minorGems checkout thol_master
elif [[ "$repo_option" == "tholHetuw" ]]; then
    addRemoteAndTrackBranches OneLife tholHetuw "https://github.com/risvh/OneLife-1.git"
    addRemoteAndTrackBranches OneLifeData7 thol "https://github.com/twohoursonelife/OneLifeData7.git"
    addRemoteAndTrackBranches minorGems tholHetuw "https://github.com/risvh/minorGems.git"
    git -C OneLife checkout tholHetuw_master
    git -C OneLifeData7 checkout thol_master
    git -C minorGems checkout tholHetuw_hetuw # minorGems for 2hol's hetuw is on a branch
elif [[ "$repo_option" == "townplanner" ]]; then
    addRemoteAndTrackBranches OneLife tholHetuw "https://github.com/risvh/OneLife-1.git"
    addRemoteAndTrackBranches OneLifeData7 thol "https://github.com/twohoursonelife/OneLifeData7.git"
    addRemoteAndTrackBranches minorGems tholHetuw "https://github.com/risvh/minorGems.git"
    git -C OneLife checkout tholHetuw_townPlanner # OneLife for town planner is on a branch of tholHetuw repo
    git -C OneLifeData7 checkout thol_master
    git -C minorGems checkout tholHetuw_townPlanner # minorGems for town planner is on a branch of tholHetuw repo
elif [[ "$repo_option" == "ohol" ]]; then
    addRemoteAndTrackBranches OneLife ohol "https://github.com/jasonrohrer/OneLife.git"
    addRemoteAndTrackBranches OneLifeData7 ohol "https://github.com/jasonrohrer/OneLifeData7.git"
    addRemoteAndTrackBranches minorGems ohol "https://github.com/jasonrohrer/minorGems.git"
    git -C OneLife checkout ohol_master
    git -C OneLifeData7 checkout ohol_master
    git -C minorGems checkout ohol_master
elif [[ "$repo_option" == "oholHetuw" ]]; then
    addRemoteAndTrackBranches OneLife oholHetuw "https://github.com/hetuw/OneLife.git"
    addRemoteAndTrackBranches OneLifeData7 ohol "https://github.com/jasonrohrer/OneLifeData7.git"
    addRemoteAndTrackBranches minorGems oholHetuw "https://github.com/hetuw/minorGems.git"
    git -C OneLife checkout oholHetuw_master
    git -C OneLifeData7 checkout ohol_master
    git -C minorGems checkout oholHetuw_master
elif [[ "$repo_option" == "origin" ]]; then
    git -C OneLife checkout master
    git -C OneLifeData7 checkout master
    git -C minorGems checkout master
else
    helpmsg
fi