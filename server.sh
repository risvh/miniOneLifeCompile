set -e
pushd .
cd "$(dirname "${0}")/.."

PLATFORM=$1
if [[ $PLATFORM == "" ]]; then PLATFORM=1; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux (Default), 5 for XCompiling for Windows"
	exit 1
fi

cd OneLife/server
./configure $PLATFORM
make

cd ../..

mkdir -p output
cd output


for f in objects transitions categories tutorialMaps; do
	if [[ $PLATFORM == 5 ]]; then
		mkdir -p $f
		cd $f
		rsync -vr ../OneLifeData7/$f/ .
		cd ..
	fi
	if [[ $PLATFORM == 1 ]]; then
		if [ ! -d $f ]; then ln -nsf ../OneLifeData7/$f .; fi
	fi
done;

cp ../OneLifeData7/dataVersionNumber.txt .
cp -r ../OneLife/server/settings .

if [[ $PLATFORM == 5 ]]; then mv ../OneLife/server/OneLifeServer.exe .; fi
if [[ $PLATFORM == 1 ]]; then mv ../OneLife/server/OneLifeServer .; fi

popd
./runServer.sh