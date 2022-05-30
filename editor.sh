set -e

PLATFORM=$(cat PLATFORM_OVERRIDE)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi

cd "$(dirname "${0}")/.."

##### Configure and Make
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi

cd OneLife
./configure $PLATFORM

cd gameSource

if [[ $PLATFORM == 5 ]]; then
	_OLD_PATH="${PATH}"; export PATH="/usr/i686-w64-mingw32/bin:${PATH}"
	cp Makefile Makefile.bak

	#Fix to make SDL statically linked
	sed -i '/^GXX =/s,$, -static `sdl-config --static-libs`,' Makefile

	#libpng depends on zlib, the order of linking flag matters
	sed -i -r '/^PLATFORM_LIBPNG_FLAG =/aPLATFORM_LIBPNG_FLAG = -lpng16 -lz' Makefile
fi

./makeEditor.sh

if [[ $PLATFORM == 5 ]]; then
	export PATH="${_OLD_PATH}"; unset _OLD_PATH
	mv Makefile.bak Makefile
fi

cd ../..


##### Create Game Folder
mkdir -p output
cd output

FOLDERS="animations categories ground music objects sounds sprites transitions"
TARGET="."
LINK="../OneLifeData7"
../miniOneLifeCompile/createSymLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK

FOLDERS="graphics otherSounds languages"
TARGET="."
LINK="../OneLife/gameSource"
../miniOneLifeCompile/createSymLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK

cp -rn ../OneLife/gameSource/settings .
cp ../OneLife/gameSource/us_english_60.txt .

cp ../OneLife/gameSource/reverbImpulseResponse.aiff .

cp ../OneLifeData7/dataVersionNumber.txt .

#missing SDL.dll
if [[ $PLATFORM == 5 ]]; then cp ../OneLife/build/win32/SDL.dll .; fi


##### Copy to Game Folder
if [[ $PLATFORM == 5 ]]; then cp -f ../OneLife/gameSource/EditOneLife.exe .; fi
if [[ $PLATFORM == 1 ]]; then cp -f ../OneLife/gameSource/EditOneLife .; fi






