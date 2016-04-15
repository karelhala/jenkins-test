#!/bin/bash
#execute this only when pull requesting to master, or pushing to master

if [ "$TRAVIS_BRANCH" = "master" ]; then
	set -e # exit with nonzero exit code if anything fails

	# go to the directory which contains build artifacts and create a *new* Git repo
	# directory may be different based on your particular build process
	cd dist
	git init
	# inside this git repo we'll pretend to be a new user

	# The first and only commit to this new Git repo contains all the
	# files present with the commit message "Deploy to GitHub Pages".
	if [ $TRAVIS_PULL_REQUEST ]; then
		rm -rf $TRAVIS_PULL_REQUEST
		mkdir $TRAVIS_PULL_REQUEST
	        cp ./* $TRAVIS_PULL_REQUEST/ -Rv 2>/dev/null || :
		rm -rf $TRAVIS_PULL_REQUEST/$TRAVIS_PULL_REQUEST/
		git add $TRAVIS_PULL_REQUEST/
	else
		git add .
	fi
	git config user.name "Travis CI"
        git config user.email "<your@email.com>"
	git commit -m "Deploy to GitHub Pages"

	# Force push from the current repo's master branch to the remote
	# repo's gh-pages branch. (All previous history on the gh-pages branch
	# will be lost, since we are overwriting it.) We redirect any output to
	# /dev/null to hide any sensitive credential data that might otherwise be exposed.
	# tokens GH_TOKEN and GH_REF will be provided as Travis CI environment variables
	git push --force "https://${GH_TOKEN}@${GH_REF}" master:gh-pages 
fi
