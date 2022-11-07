#!/bin/bash
set -e
cd "$(dirname "${0}")/../.."
        
repo=$1
remote=$2
newBranchName=$3

prefix="${remote}_"        
git -C $repo checkout -b "${prefix}${newBranchName}"
git -C $repo push -u $remote "${prefix}${newBranchName}":$newBranchName