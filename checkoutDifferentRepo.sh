#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

helpmsg() {
	echo "Options to checkout: "
	echo "  thol        - client, server and editor"
	echo "  thol_hetuw  - client"
	echo "  townplanner - editor"
	echo "  ohol        - client, server and editor"
	echo "  ohol_hetuw  - client"
}

if [[ "$1" == "" ]]; then 
	helpmsg
    exit 1
fi

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

repo_option="$1"

if [[ "$repo_option" == "thol" ]]; then
	git -C OneLife checkout thol/master
	git -C OneLifeData7 checkout thol/master
	git -C minorGems checkout thol/master
elif [[ "$repo_option" == "thol_hetuw" ]]; then
	git -C OneLife checkout thol_hetuw/master
	git -C OneLifeData7 checkout thol/master
	git -C minorGems checkout ohol_hetuw/master
	# Hetuw v268 works for 2HOL, that was before login format changes
	# git -C OneLife checkout 1ab17ba #268 Oct4 2019
	# git -C minorGems checkout 4f3991f #266 Sep28 2019
elif [[ "$repo_option" == "townplanner" ]]; then
	# Town planner is on a branch of the thol_hetuw repo
	# it uses an old version of ohol_hetuw minorGems
	git -C OneLife checkout thol_hetuw/townPlanner
	git -C OneLifeData7 checkout thol/master
	git -C minorGems checkout 4f3991f #266 Sep28 2019
elif [[ "$repo_option" == "ohol" ]]; then
	git -C OneLife checkout ohol/master
	git -C OneLifeData7 checkout ohol/master
	git -C minorGems checkout ohol/master
elif [[ "$repo_option" == "ohol_hetuw" ]]; then
	git -C OneLife checkout ohol_hetuw/master
	git -C OneLifeData7 checkout ohol/master
	git -C minorGems checkout ohol_hetuw/master
else
	helpmsg
fi