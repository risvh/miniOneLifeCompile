#!/bin/bash
set -e
# PLATFORM=$(cat PLATFORM_OVERRIDE)
# if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
# if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	# echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	# exit 1
# fi
cd "$(dirname "${0}")/.."

mkdir -p output
cd output

folderList="animations categories ground music objects sounds sprites transitions"

#Copying from OneLifeData7
for f in $folderList; do
    
	###### Create sym link only
	# if [[ $PLATFORM == 1 ]] && [ ! -h $f ]; then ln -s ../OneLifeData7/$f .; fi
    # if [[ $PLATFORM == 5 ]] && [ ! -h $f ]; then ../miniOneLifeCompile/mklink.sh /J $f ../OneLifeData7/$f; fi
	
	###### Full copy
	# if [ ! -d $f ]; then cp -RL -v ../OneLifeData7/$f .; fi
	
	###### Sync only when different
    if [ -h $f ]; then rm $f; fi
    mkdir -p $f
    cd $f
    rsync -vr ../../OneLifeData7/$f/ .
    cd ..
	
done;


folderList="graphics otherSounds languages"

#Copying from OneLife/gameSource
for f in $folderList; do
    
	###### Create sym link only
	# if [[ $PLATFORM == 1 ]] && [ ! -h $f ]; then ln -s ../OneLife/gameSource/$f .; fi
    # if [[ $PLATFORM == 5 ]] && [ ! -h $f ]; then ../miniOneLifeCompile/mklink.sh /J $f ../OneLife/gameSource/$f; fi
	
	###### Full copy
	# if [ ! -d $f ]; then cp -RL -v ../OneLife/gameSource/$f .; fi
	
	###### Sync only when different
    if [ -h $f ]; then rm $f; fi
    mkdir -p $f
    cd $f
    rsync -vr ../../OneLife/gameSource/$f/ .
    cd ..
	
done;