set -e
cd "$(dirname "${0}")/.."

clearCache=${1-0}

find . -type f -name '*.o' -exec rm {} +
find . -type f -name '*.dep' -exec rm {} +
find . -type f -name '*.dep2' -exec rm {} +

if [[ $clearCache == 1 ]]; then find . -type f -name '*.fcz' -exec rm {} +; fi