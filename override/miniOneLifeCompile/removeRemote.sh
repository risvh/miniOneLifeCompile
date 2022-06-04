#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

repo=$1
remote=$2

### Check out master branch first
git -C $repo checkout --detach

### Delete all branches prefixed with the remote name, except the one checked out
git -C $repo branch | grep "${remote}_" | grep -v \* | xargs -r git -C $repo branch -D 

### Remove the remote
git -C $repo remote remove $remote