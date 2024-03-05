#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."

repos=${1-"OneLife OneLifeData7 minorGems"}

for repo in $repos; do
    ### Discard changes of unstaged files
    git -C $repo restore .

    ### Remove untracked files
    git -C $repo clean -fxd
done
