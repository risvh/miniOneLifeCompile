set -e
cd "$(dirname "${0}")/.."

PLATFORM=${1-5}
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi

mkdir -p output
cd output

folderList="animations categories ground music objects sounds sprites transitions"

#Copying from OneLifeData7
for f in $folderList; do
    
	###### Create sym link only
	# if [[ $PLATFORM == 1 ]] && [ ! -h $f ]; then ln -s ../OneLifeData7/$f .; fi
    # if [[ $PLATFORM == 5 ]] && [ ! -h $f ]; then ../miniOneLifeCompile/mklink.sh /J $f ../OneLifeData7/$f; fi
	
	###### Full copy from OneLifeData7 repo
	# if [ ! -d $f ]; then cp -RL -v ../OneLifeData7/$f .; fi
	
	###### Sync only when different
    if [ -h $f ]; then rm $f; fi
    mkdir -p $f
    cd $f
    rsync -vr ../../OneLifeData7/$f/ .
    cd ..
	
done;