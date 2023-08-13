#!/bin/bash
set -e
PLATFORM=$(cat PLATFORM_OVERRIDE)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi
cd "$(dirname "${0}")/../.."


###### Paths Required by Discord SDK
COMPILE_ROOT=$(pwd)
DISCORD_SDK_PATH="$COMPILE_ROOT/dependencies/discord_game_sdk"
MINOR_GEMS_PATH="$COMPILE_ROOT/minorGems"


###### Name the Release Folder
version=$(<OneLifeData7/dataVersionNumber.txt)
if [[ $PLATFORM == 1 ]]; then outputName="2HOL_v${version}_linux"; fi
if [[ $PLATFORM == 5 ]]; then outputName="2HOL_v${version}_win"; fi

mkdir -p $outputName
cd $outputName


###### Copy Asset folders
pathList=()
folderList=()

temp="animations categories ground music objects sounds sprites transitions"
for f in $temp; do folderList+=( "$f" ); done;
for f in $temp; do pathList+=( "../OneLifeData7/$f" ); done;

temp="graphics otherSounds languages settings"
for f in $temp; do folderList+=( "$f" ); done;
for f in $temp; do pathList+=( "../OneLife/gameSource/$f" ); done;

for i in ${!pathList[@]}; do
    
	###### Create sym link only
	# if [[ $PLATFORM == 1 ]] && [ ! -h ${folderList[$i]} ]; then ln -s ${pathList[$i]} .; fi
    # if [[ $PLATFORM == 5 ]]; then
        # if [ -h ${folderList[$i]} ]; then rm ./${folderList[$i]}; fi
        # ../miniOneLifeCompile/util/mklink.sh /J ${folderList[$i]} ${pathList[$i]}
    # fi
	
	###### Full copy
    if [ -e ${folderList[$i]} ]; then rm ./${folderList[$i]}; fi
	cp -RL -v ${pathList[$i]} .
	
	###### Sync only when different
    # if [ -h ${folderList[$i]} ]; then rm ${folderList[$i]}; fi
    # mkdir -p ${folderList[$i]}
    # rsync -vru --delete ${pathList[$i]}/ ${folderList[$i]}
	
done;


###### Copy Data Version and other files
cp ../OneLife/gameSource/language.txt .
cp ../OneLife/gameSource/us_english_60.txt .
cp ../OneLife/documentation/Readme.txt .
cp ../OneLife/no_copyright.txt .
cp ../OneLife/gameSource/reverbImpulseResponse.aiff .
cp ../OneLife/server/wordList.txt .

d=$(TZ=":GMT" date)
echo "$1 built on $d" > binary.txt

cp ../OneLifeData7/dataVersionNumber.txt .


###### SDL and clearCache script
if [[ $PLATFORM == 5 ]] && [ ! -f SDL.dll ]; then cp ../OneLife/build/win32/SDL.dll .; fi
if [[ $PLATFORM == 5 ]] && [ ! -f clearCache.bat ]; then cp ../OneLife/build/win32/clearCache.bat .; fi


###### Change EOL
if [[ $PLATFORM == 1 ]]; then
    find . -type f -name '*.txt' -exec sed -i 's/\r//g' {} +
fi

if [[ $PLATFORM == 5 ]]; then
    cp ../OneLife/build/unix2dos.c .
    cp ../OneLife/build/unix2dosScript .
    g++ -o unix2dos unix2dos.c

    find . -type f -name 'unix2dosScript' -exec sed -i 's/\r//g' {} +

    for file in $( find . -name "*.txt" )
    do
        echo "$file"
        ./unix2dosScript "$file"
    done

    rm unix2dos.c
    rm unix2dosScript
    rm unix2dos
fi


###### Compile the Game Exe
cd ../miniOneLifeCompile
./cleanOldBuildsAndOptionallyCaches.sh 1
./applyFixesAndOverride.sh
cd ..

cd OneLife
if [ -d $DISCORD_SDK_PATH ]; then
	./configure $PLATFORM "$MINOR_GEMS_PATH" --discord_sdk_path "${DISCORD_SDK_PATH}"
else
	./configure $PLATFORM
fi
cd gameSource
if [[ $PLATFORM == 5 ]]; then export PATH="/usr/i686-w64-mingw32/bin:${PATH}"; fi
make
cd ../..
cd $outputName


###### Copy Discord SDK
if [ -d $DISCORD_SDK_PATH ]; then
	# windows: copy discord_game_sdk.dll into the output folder
	if [[ $PLATFORM == 5 ]]; then cp $DISCORD_SDK_PATH/lib/x86/discord_game_sdk.dll ./; fi
	# linux: copy discord_game_sdk.so into the output folder
	if [[ $PLATFORM == 1 ]]; then
		if [[ ! -f ./discord_game_sdk.so ]]; then
			sudo cp $DISCORD_SDK_PATH/lib/x86_64/discord_game_sdk.so ./
			sudo chmod a+r ./discord_game_sdk.so
		fi
	fi
fi


###### Copy to Game Folder
if [[ $PLATFORM == 1 ]]; then
    mv -f ../OneLife/gameSource/OneLife .
fi

if [[ $PLATFORM == 5 ]]; then
    mv -f ../OneLife/gameSource/OneLife.exe .
fi
