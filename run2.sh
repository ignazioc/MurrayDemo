#!/bin/bash
set -e
echo "#" >> run.sh
# commit & push
git add -A; git commit --allow-empty-message -m ''; git push

cd ..
rm -rf "NewFramework"


git clone https://github.com/ignazioc/MurrayDemo.git NewFramework

cd NewFramework

code .