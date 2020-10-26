pushd .
cd ../output
find . -type f -name '*.db' -exec rm {} +
rm -f testMapStale.txt
popd
./runServer.sh