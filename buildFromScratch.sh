#!/bin/bash

set -e


./getDependencies.sh


./cloneRepos.sh risvh


./applyFixesAndOverride.sh


./compile.sh
