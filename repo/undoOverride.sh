#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."

repo=$1


### Stage all files
git -C $repo add .

### Loop through the override files
for f in $(find -path "./miniOneLifeCompile/override/${repo}/*" -type f); do
    
    old="miniOneLifeCompile/override/"$repo"/"
    new=""
    p="${f/"$old"/"$new"}"
    
    ### Unstage these override files
    git -C $repo restore --staged $p

done

### Discard changes of unstaged files
git -C $repo restore .

### Remove untracked files
git -C $repo clean -fxd