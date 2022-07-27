#!/bin/bash
set -e
PLATFORM=$(cat PLATFORM_OVERRIDE)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-1}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux (Default), 5 for XCompiling for Windows"
	exit 1
fi
cd "$(dirname "${0}")/.."

cd output
if [[ $PLATFORM == 5 ]]; then cmd.exe /c  OneLifeServer.exe; fi
if [[ $PLATFORM == 1 ]]; then ./OneLifeServer; fi