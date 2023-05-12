#!/bin/bash
set -e
PLATFORM=$(cat PLATFORM_OVERRIDE)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi
cd "$(dirname "${0}")/.."

COMPILE_ROOT=$(pwd)
DISCORD_SDK_PATH="$COMPILE_ROOT/dependencies/discord_game_sdk"
MINRO_GEMS_PATH="$COMPILE_ROOT/minorGems"

##### Configure and Make
cd OneLife
if [ -d $DISCORD_SDK_PATH ]; then
	./configure $PLATFORM "$MINRO_GEMS_PATH" --discord_sdk_path "${DISCORD_SDK_PATH}"
else
	./configure $PLATFORM
fi
cd gameSource
if [[ $PLATFORM == 5 ]]; then export PATH="/usr/i686-w64-mingw32/bin:${PATH}"; fi
make

cd ../..


##### Create Game Folder
mkdir -p output
cd output

if [ -d $DISCORD_SDK_PATH ]; then
	# windows: copy discord_game_sdk.dll into the output folder
	if [[ $PLATFORM == 5 ]]; then cp $DISCORD_SDK_PATH/lib/x86/discord_game_sdk.dll ./; fi
	# linux: copy discord_game_sdk.so into the local libs folder
	if [[ $PLATFORM == 1 ]]; then
		if [[ ! -f /usr/lib/discord_game_sdk.so ]]; then
			echo "copying discord_game_sdk.so library"
			sudo cp $DISCORD_SDK_PATH/lib/x86_64/discord_game_sdk.so /usr/lib/
			sudo chmod a+r /usr/lib/discord_game_sdk.so
		fi
	fi
fi
FOLDERS="animations categories ground music objects sounds sprites transitions"
TARGET="."
LINK="../OneLifeData7"
../miniOneLifeCompile/util/createSymLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK

FOLDERS="graphics otherSounds languages"
TARGET="."
LINK="../OneLife/gameSource"
../miniOneLifeCompile/util/createSymLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK

cp -rn ../OneLife/gameSource/settings .
cp ../OneLife/gameSource/reverbImpulseResponse.aiff .
cp ../OneLife/server/wordList.txt .

cp ../OneLifeData7/dataVersionNumber.txt .

#missing SDL.dll and clearCache script
if [[ $PLATFORM == 5 ]] && [ ! -f SDL.dll ]; then cp ../OneLife/build/win32/SDL.dll .; fi
if [[ $PLATFORM == 5 ]] && [ ! -f clearCache.bat ]; then cp ../OneLife/build/win32/clearCache.bat .; fi


##### Copy to Game Folder and Run
if [[ $PLATFORM == 5 ]]; then
	rm -f OneLife.exe
	cp ../OneLife/gameSource/OneLife.exe .
	#rm ../OneLife/gameSource/OneLife.exe # this causes it to wait ~15s without any reason!
	echo "Starting OneLife.exe"
	cmd.exe /c OneLife.exe
fi
if [[ $PLATFORM == 1 ]]; then
	mv -f ../OneLife/gameSource/OneLife .
	echo "Starting OneLife"
	./OneLife
fi
