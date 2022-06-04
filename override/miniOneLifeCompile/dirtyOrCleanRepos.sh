#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

repos=${1-"OneLife OneLifeData7 minorGems"}

clean=1
for repo in $repos; do
    if [[ -n "$(git -C $repo status --porcelain)" ]]; then
        clean=0
    fi
done

echo $clean