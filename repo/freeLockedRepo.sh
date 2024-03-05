#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."

repos=${1-"OneLife OneLifeData7 minorGems"}

for repo in $repos; do
    ### Refresh index
    git -C $repo status
done
