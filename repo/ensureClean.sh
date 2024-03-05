#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."

repos=${1-"OneLife OneLifeData7 minorGems"}

dirty=0
for repo in $repos; do
    if [[ -n "$(git -C $repo status --porcelain)" ]]; then
        echo "$repo contains modified or untracked files"
        dirty=1
    fi
done

if [ "$dirty" -ne 0 ]; then
    read -p "Discard all changes? (y/n)" reply
    if [[ "$reply" == "y" ]]; then
        for repo in $repos; do
            ### Discard changes of unstaged files
            git -C $repo restore .

            ### Remove untracked files
            git -C $repo clean -fxd
        done
    else
        echo "Abort"
        exit 1
    fi
fi