#!/bin/bash
set -e

# commit & push
git add -A; git commit --allow-empty-message -m ''; git push

cd ..
rm -rf "NewFramework"
murray skeleton new NewFramework https://github.com/ignazioc/MurrayDemo.git --verbose

code NewFramework