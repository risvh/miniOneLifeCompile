#!/bin/bash
set -e

cd override

### This more or less undo ./applyFixesAndOverride.sh ...

### Don't undo the overridden compile scripts, if any
for f in $(find -path '*' -not -path '*/miniOneLifeCompile/*.sh' -type f); do
    
    ### Could have overridden files in the output folder...
    if [[ $(git -C $(dirname ../../$f) rev-parse --is-inside-work-tree 2>/dev/null) != "true" ]]; then
        echo "Not Git: $f"
        continue
    fi
    
    ### Remove added files, reset changed files
    if [[ "$(git -C $(dirname ../../$f) ls-files $(basename ../../$f))" == "" ]]; then
        echo "Delete: $f"
        rm -f ../../$f
    else
        echo "Reset: $f"
        git -C $(dirname ../../$f) checkout -- $(basename ../../$f)
    fi
done


cd ..

### Change EOL back to Windows-style
find ../OneLife -type f \( -name 'configure' \) -exec sed -i 's/$/\r/g' {} +