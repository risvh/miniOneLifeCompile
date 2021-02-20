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
make
cd ../..

mkdir -p output
cd output

if [[ $PLATFORM == 5 ]]; then
	mv -f ../OneLife/gameSource/OneLife.exe .
	cmd.exe /c OneLife.exe
fi
if [[ $PLATFORM == 1 ]]; then
	mv -f ../OneLife/gameSource/OneLife .
	./OneLife
fi