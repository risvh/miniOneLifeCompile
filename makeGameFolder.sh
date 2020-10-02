set -e
cd "$(dirname "${0}")/.."

mkdir -p output
cd output


#Copying from OneLifeData7
for f in animations categories ground music objects sounds sprites transitions; do
    
	###### Create sym link only
	# if [ ! -h $f ]; then ln -s ../OneLifeData7/$f .; fi
	
	###### Full copy from OneLifeData7 repo
	# if [ ! -d $f ]; then cp -RL -v ../OneLifeData7/$f .; fi
	
	###### Sync only when different
	if [ -h $f ]; then rm $f; fi
	mkdir -p $f
	cd $f
	rsync -vr ../../OneLifeData7/$f/ .
	cd ..
	
done;

cp ../OneLifeData7/dataVersionNumber.txt .

#Copying from OneLife
cp ../OneLife/documentation/Readme.txt .
cp ../OneLife/no_copyright.txt .
cp ../OneLife/gameSource/language.txt .
cp ../OneLife/gameSource/us_english_60.txt .
cp ../OneLife/gameSource/reverbImpulseResponse.aiff .
cp ../OneLife/gameSource/wordList.txt .
cp -r ../OneLife/gameSource/graphics .
cp -r ../OneLife/gameSource/otherSounds .
cp -r ../OneLife/gameSource/settings .
cp -r ../OneLife/gameSource/languages .


#missing SDL.dll
cp ../OneLife/build/win32/SDL.dll .