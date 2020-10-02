set -e
cd "$(dirname "${0}")/.."

find . -type f -name '*.o' -exec rm {} +
find . -type f -name '*.dep' -exec rm {} +

find . -type f -name '*.fcz' -exec rm {} +