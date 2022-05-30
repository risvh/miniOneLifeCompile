	#!/bin/bash
set -e

cd "$(dirname "${0}")/.."

#2HOL
THOL_CODE_REPO="https://github.com/twohoursonelife/OneLife.git"
THOL_DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
THOL_GEMS_REPO="https://github.com/twohoursonelife/minorGems.git"
RISVH_CODE_REPO="https://github.com/risvh/OneLife-1.git"

#OHOL
OHOL_CODE_REPO="https://github.com/jasonrohrer/OneLife.git"
OHOL_DATA_REPO="https://github.com/jasonrohrer/OneLifeData7.git"
OHOL_GEMS_REPO="https://github.com/jasonrohrer/minorGems.git"
HETUW_CODE_REPO="https://github.com/hetuw/OneLife.git"
HETUW_GEMS_REPO="https://github.com/hetuw/minorGems.git"

if [[ ! -d OneLife ]]; then
	git clone $THOL_CODE_REPO OneLife
	git -C OneLife remote add ohol_hetuw $HETUW_CODE_REPO
	git -C OneLife remote add thol_hetuw $RISVH_CODE_REPO
	git -C OneLife remote add ohol $OHOL_CODE_REPO
	git -C OneLife remote add thol $THOL_CODE_REPO
	git -C OneLife fetch --all
fi
if [[ ! -d OneLifeData7 ]]; then
	git clone $THOL_DATA_REPO OneLifeData7
	git -C OneLifeData7 remote add ohol $OHOL_DATA_REPO
	git -C OneLifeData7 remote add thol $THOL_DATA_REPO
	git -C OneLifeData7 fetch --all
fi
if [[ ! -d minorGems ]]; then
	git clone $THOL_GEMS_REPO minorGems
	git -C minorGems remote add ohol_hetuw $HETUW_GEMS_REPO
	git -C minorGems remote add ohol $OHOL_GEMS_REPO
	git -C minorGems remote add thol $THOL_GEMS_REPO
	git -C minorGems fetch --all
fi

helpmsg() {
	echo "Options to checkout: "
	echo "  thol (DEFAULT) - client, server and editor"
	echo "  thol_hetuw - client"
	echo "  townplanner - editor"
	echo "  ohol - client, server and editor"
	echo "  ohol_hetuw - client"
}

repo_option="${1-thol}"

if [[ "$1" == "" ]]; then 
	helpmsg
    echo "Checking out 2HOL repos by default."
fi

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
