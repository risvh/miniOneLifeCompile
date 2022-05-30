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


