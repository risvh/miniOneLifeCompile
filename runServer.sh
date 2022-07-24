#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

PLATFORM=$1
if [[ $PLATFORM == "" ]]; then PLATFORM=5; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi

cd output
if [[ $PLATFORM == 5 ]]; then ./OneLifeServer; fi
if [[ $PLATFORM == 1 ]]; then cmd.exe /c  OneLifeServer.exe; fi