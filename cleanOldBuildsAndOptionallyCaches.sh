#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

clearCache=${1-0}

find . -type f -name '*.o' -exec rm -f {} +
find . -type f -name '*.dep' -exec rm -f {} +
find . -type f -name '*.dep2' -exec rm -f {} +

if [[ $clearCache == 1 ]]; then find . -type f -name '*.fcz' -exec rm -f {} +; fi