#!/bin/bash
pushd .
cd "$(dirname "${0}")/..";

#Fix winsock letter case (For cross-compiling client for Windows on Linux)
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/win32/SocketClientWin32.cpp;
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/win32/SocketServerWin32.cpp;

#Obsolete values.h is replaced by float.h (For cross-compiling server for Windows on Linux)
sed -i 's/<values.h>/<float.h>/' OneLife/server/map.cpp;
#Fix winsock letter case (For cross-compiling server for Windows on Linux)
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/unix/SocketPollUnix.cpp;

popd

cd override
rsync -vr . ../..

cd ..

#Make sure it has Unix EOL
find ../OneLife -type f \( -name 'configure' \) -exec sed -i 's/\r//g' {} +
find ../OneLife -type f \( -name '*.sh' \) -exec sed -i 's/\r//g' {} +
find ../OneLife -type f \( -name 'Makefile*' \) -exec sed -i 's/\r//g' {} +

#libpng depends on zlib, the order of linking flag matters
sed -i 's/PLATFORM_LIBPNG_FLAG = -lz -lpng/PLATFORM_LIBPNG_FLAG = -lpng -lz/' ../minorGems/game/platforms/SDL/Makefile.MinGWCross

#Fix to make SDL statically linked
sed -i '/ -static `sdl-config --static-libs`$/! s/^PLATFORM_LIBPNG_FLAG .*$/& -static `sdl-config --static-libs`/' ../minorGems/game/platforms/SDL/Makefile.MinGWCross

#New versions of imagemagick flips images after conversion
# im_version=`convert -list configure | sed '/^LIB_VERSION_NUMBER */!d; s//,/;  s/,/,0/g;  s/,0*\([0-9][0-9]\)/\1/g' | head -n 1`
# if [ "$im_version" -lt "06110000" ]; then
	# sed -i 's/convert $< -type truecolormatte $@/convert -auto-orient $< -type truecolormatte $@/' ../minorGems/game/platforms/SDL/Makefile.all
# fi
#sed -i 's/convert $< -type truecolormatte $@/convert -auto-orient $< -type truecolormatte $@/' ../minorGems/game/platforms/SDL/Makefile.all

# fix include windows.h letter case in discord_sdk (For cross-compiling client for Windows on Linux)
sed -i 's/<Windows.h>/<windows.h>/' ../dependencies/discord_game_sdk/c/discord_game_sdk.h;
