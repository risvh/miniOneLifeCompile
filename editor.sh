set -e
cd "$(dirname "${0}")/.."

PLATFORM=$1
if [[ $PLATFORM == "" ]]; then PLATFORM=5; fi
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
cd output
if [[ $PLATFORM == 5 ]]; then cp -f ../OneLife/gameSource/EditOneLife.exe .; fi
if [[ $PLATFORM == 1 ]]; then cp -f ../OneLife/gameSource/EditOneLife .; fi






