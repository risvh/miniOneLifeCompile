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
find .. -type f -name '*.sh' -exec sed -i 's/\r//g' {} +
find .. -type f -name 'configure' -exec sed -i 's/\r//g' {} +
find ../OneLife/build -type f \( -name '*.sh' -o ! -name '*.*' \) -exec sed -i 's/\r//g' {} +