#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

repo=$1
remote=$2
prNum=$3

### Clean repo first
./miniOneLifeCompile/ensureClean.sh $1

### Fetch and checkout the PR as a new local branch
git -C $repo fetch $remote pull/$prNum/head:${remote}_pr_$prNum
git -C $repo checkout ${remote}_pr_$prNum