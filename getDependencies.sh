#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

sudo apt-get update

sudo apt-get install -y rsync wget

sudo apt-get install -y git

sudo apt-get install -y imagemagick xclip libglu1-mesa-dev libgl1-mesa-dev libsdl1.2-dev

sudo apt-get install -y mingw-w64

sudo apt-get install -y build-essential


mkdir -p dependencies
cd dependencies

if [ ! -d SDL* ]; then
	wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz -O- | tar xfz -
	cd SDL*
	./configure \
		--bindir=/usr/i686-w64-mingw32/bin \
		--libdir=/usr/i686-w64-mingw32/lib \
		--includedir=/usr/i686-w64-mingw32/include \
		--host=i686-w64-mingw32 \
		--prefix=/usr/i686-w64-mingw32 \
		CPPFLAGS="-I/usr/i686-w64-mingw32/include" \
		LDFLAGS="-L/usr/i686-w64-mingw32/lib"
	make
	sudo make install
fi