#!/usr/bin/env sh

# Simple script to deploy ShareIt! automatically to the different static web
# hostings and have all of them updated.
#
# It will be of none interest for you since it's only purposed for internal use


PRODUCTION_BRANCH="gh-pages"


echo
echo "* Looking for remote changes on master branch *"
git checkout master
git pull --ff-only

status=$?
if [ $status -ne 0 ];then
    echo "* There was a problem pulling from master *"
    echo "* Probably a non fast-forward merge       *"
    exit $status
fi

echo
echo "* Push changes to GitHub master branch *"
git push origin master

echo
echo "* Update changes on production branch (gh-pages) *"
git checkout $PRODUCTION_BRANCH
git merge master
git rm -r "daemon" "doc" "html_basic" "test images" "COLLABORATE.md" "deploy.sh" "README.md"
git commit --amend

# Come back to master branch
git checkout master

echo
echo "* Deploy in GitHub *"
git push --force origin $PRODUCTION_BRANCH

echo
echo "* Deploy to 5Apps *"
git push --force 5apps $PRODUCTION_BRANCH:master


echo
echo ""
