#!/bin/bash

set -e


./getDependencies.sh


./cloneRepos.sh


./applyFixesAndOverride.sh


./makeGameFolder.sh


./compile.sh