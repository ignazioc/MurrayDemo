#!/bin/bash
set -e
echo "#" >> run.sh

NEWNAME=NewFramework
# commit & push
git add -A; git commit --allow-empty-message -m ''; git push

cd ..
rm -rf "NewFramework"


git clone https://github.com/ignazioc/MurrayDemo.git NewFramework

cd NewFramework


# Rename main folder.
mv EBKUI $NEWNAME
mv Example/EBKUI Example/${NEWNAME}
mv Example/EBKUI.xcodeproj Example/${NEWNAME}.xocdeproj
mv Example/EBKUI.xcworkspace Example/${NEWNAME}.xcworkspace
nv EBKUI.podspec ${NEWNAME}.podspec
code .