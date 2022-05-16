#!/bin/bash

set -e


./getDependencies.sh


./cloneRepos.sh


./applyFixesAndOverride.sh


./compile.sh