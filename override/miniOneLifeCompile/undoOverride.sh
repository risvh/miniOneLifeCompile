# set -e

cd override

for f in $(find -path '*' -not -path '*/miniOneLifeCompile/*.sh' -type f); do
    
    if [[ $(git -C $(dirname ../../$f) rev-parse --is-inside-work-tree 2>/dev/null) != "true" ]]; then
        echo "Not Git: $f"
        continue
    fi
    
    if [[ "$(git -C $(dirname ../../$f) ls-files $(basename ../../$f))" == "" ]]; then
        echo "Delete: $f"
        rm -f ../../$f
    else
        echo "Reset: $f"
        git -C $(dirname ../../$f) checkout -- $(basename ../../$f)
    fi
done


