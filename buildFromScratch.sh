#!/bin/bash

set -e


./getDependencies.sh


./cloneReposAndCheckout.sh


./applyFixesAndOverride.sh


./compile.sh
