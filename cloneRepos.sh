#!/bin/bash
cd "$(dirname "${0}")/.."

#2HOL
CODE_REPO="https://github.com/twohoursonelife/OneLife.git"
DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
GEMS_REPO="https://github.com/twohoursonelife/minorGems.git"

#Hetuw for 2HOL with minitech
# CODE_REPO="https://github.com/risvh/OneLife-1.git"
# DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
# GEMS_REPO="https://github.com/hetuw/minorGems.git"

#Hetuw v268 (for 2HOL, before login format was changed)
# CODE_REPO="https://github.com/hetuw/OneLife.git"
# DATA_REPO="https://github.com/twohoursonelife/OneLifeData7.git"
# GEMS_REPO="https://github.com/hetuw/minorGems.git"

#OHOL
# CODE_REPO="https://github.com/jasonrohrer/OneLife.git"
# DATA_REPO="https://github.com/jasonrohrer/OneLifeData7.git"
# GEMS_REPO="https://github.com/jasonrohrer/minorGems.git"


if [[ ! -d OneLife ]]; then git clone $CODE_REPO OneLife; fi
if [[ ! -d OneLifeData7 ]]; then git clone $DATA_REPO OneLifeData7; fi
if [[ ! -d minorGems ]]; then git clone $GEMS_REPO minorGems; fi

#Hetuw for 2HOL with minitech (Town planner)
# git -C "OneLife" checkout townPlanner;
# git -C "minorGems" checkout 4f3991f #266 Sep28 2019

#Hetuw v268 (for 2HOL, before login format was changed)
# git -C "OneLife" checkout 1ab17ba #268 Oct4 2019
# git -C "minorGems" checkout 4f3991f #266 Sep28 2019







