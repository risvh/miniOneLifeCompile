#!/bin/bash
cd "$(dirname "${0}")/.."

#2HOL
THOL_CODE_REPO="https://github.com/twohoursonelife/OneLife.git"
THOL_DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
THOL_GEMS_REPO="https://github.com/twohoursonelife/minorGems.git"

#Hetuw for 2HOL with minitech
RISVH_CODE_REPO="https://github.com/risvh/OneLife-1.git"
# THOL_DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
HETUW_GEMS_REPO="https://github.com/hetuw/minorGems.git"

#Hetuw v268 (for 2HOL, before login format was changed)
HETUW_CODE_REPO="https://github.com/hetuw/OneLife.git"
# THOL_DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
# HETUW_GEMS_REPO="https://github.com/hetuw/minorGems.git"

#OHOL
OHOL_CODE_REPO="https://github.com/jasonrohrer/OneLife.git"
OHOL_DATA_REPO="https://github.com/jasonrohrer/OneLifeData7.git"
OHOL_GEMS_REPO="https://github.com/jasonrohrer/minorGems.git"


MY_CODE_REPO="$RISVH_CODE_REPO"
MY_DATA_REPO="$THOL_DATA_REPO"
MY_GEMS_REPO="$HETUW_GEMS_REPO"
if [[ ! -d OneLife ]]; then
	git clone $MY_CODE_REPO OneLife
	git -C OneLife remote add hetuw $HETUW_CODE_REPO
	git -C OneLife remote add risvh $RISVH_CODE_REPO
	git -C OneLife remote add jasonrohrer $OHOL_CODE_REPO
	git -C OneLife remote add twohoursonelife $THOL_CODE_REPO
fi
if [[ ! -d OneLifeData7 ]]; then
	git clone $MY_DATA_REPO OneLifeData7
	git -C OneLifeData7 remote add twohoursonelife $THOL_DATA_REPO
	git -C OneLifeData7 remote add jasonrohrer $OHOL_DATA_REPO
fi
if [[ ! -d minorGems ]]; then
	git clone $MY_GEMS_REPO minorGems
	git -C minorGems remote add twohoursonelife $THOL_GEMS_REPO
	git -C minorGems remote add jasonrohrer $OHOL_GEMS_REPO
	git -C minorGems remote add hetuw $HETUW_GEMS_REPO
fi

git -C OneLife fetch --all
git -C OneLifeData7 fetch --all
git -C minorGems fetch --all

helpmsg() {
	echo "Repositories are up to date. Options to checkout: "
	echo "  thol-server"
	echo "  thol-client"
	echo "  risvh-client"
	echo "  town-planner"
	echo "  hetuw-old"
	echo "  ohol-client"
	echo "  ohol-server"

}

if [[ "$1" == "" ]]; then
	helpmsg
	echo -n "Input selection: "
	read -r repo_option
else
	repo_option="$1"
fi

if [[ "$repo_option" == "thol-server" ]]; then
	git -C "OneLife" checkout twohoursonelife/master
	git -C "OneLifeData7" checkout twohoursonelife/master
	git -C "minorGems" checkout twohoursonelife/master
elif [[ "$repo_option" == "thol-client" ]]; then
	git -C "OneLife" checkout twohoursonelife/master
	git -C "OneLifeData7" checkout twohoursonelife/master
	git -C "minorGems" checkout twohoursonelife/master
elif [[ "$repo_option" == "risvh-client" ]]; then
	git -C "OneLife" checkout risvh/master
	git -C "OneLifeData7" checkout twohoursonelife/master
	git -C "minorGems" checkout hetuw/master
elif [[ "$repo_option" == "ohol-client" ]]; then
	git -C "OneLife" checkout jasonrohrer/master
	git -C "OneLifeData7" checkout jasonrohrer/master
	git -C "minorGems" checkout jasonrohrer/master
elif [[ "$repo_option" == "ohol-server" ]]; then
	git -C "OneLife" checkout jasonrohrer/master
	git -C "OneLifeData7" checkout jasonrohrer/master
	git -C "minorGems" checkout jasonrohrer/master

#Hetuw for 2HOL with minitech (Town planner)
elif [[ $repo_option == "town-planner" ]]; then
  git -C "OneLife" checkout risvh/townPlanner;
  git -C "minorGems" checkout 4f3991f #266 Sep28 2019

#Hetuw v268 (for 2HOL, before login format was changed)
elif [[ $repo_option == "hetuw-old" ]]; then
  git -C "OneLife" checkout 1ab17ba #268 Oct4 2019
  git -C "minorGems" checkout 4f3991f #266 Sep28 2019
else
	helpmsg
fi







