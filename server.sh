set -e
pushd .
cd "$(dirname "${0}")/.."


##### Configure and Make
PLATFORM=${1-1}
if [[ $PLATFORM == "" ]]; then PLATFORM=1; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux (Default), 5 for XCompiling for Windows"
	exit 1
fi

cd OneLife/server
./configure $PLATFORM
make

cd ../..


##### Create Game Folder
mkdir -p output
cd output

FOLDERS="objects transitions categories tutorialMap"
TARGET="."
LINK="../OneLifeData7"
../miniOneLifeCompile/createSymLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK


cp -rn ../OneLife/server/settings .

cp ../OneLife/server/firstNames.txt .
cp ../OneLife/server/lastNames.txt .
cp ../OneLife/server/wordList.txt .

cp ../OneLifeData7/dataVersionNumber.txt .


##### Copy to Game Folder and Run
if [[ $PLATFORM == 5 ]]; then mv ../OneLife/server/OneLifeServer.exe .; fi
if [[ $PLATFORM == 1 ]]; then mv ../OneLife/server/OneLifeServer .; fi

popd
./runServer.sh