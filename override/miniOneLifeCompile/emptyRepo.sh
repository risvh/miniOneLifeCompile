#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

repo=$1

git -C $repo checkout --detach # Detach HEAD
git -C $repo remote | xargs -r -n1 git -C $repo remote remove # Remove all remotes
git -C $repo branch | grep -v \* | xargs -r git -C $repo branch -D # Remove all branches