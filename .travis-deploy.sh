#!/bin/bash
#execute this only when pull requesting to master, or pushing to master
export GH_BRANCH=gh-pages
# run this only if branch is master and we are not in pull request
if [ "$TRAVIS_BRANCH" = "master" ] && [ $TRAVIS_PULL_REQUEST = "false" ]; then
	set -e
	rm -rf ../"${GH_BRANCH}"
	git clone -b ${GH_BRANCH} "https://${GH_REF}" ../"${GH_BRANCH}"

	cp ./dist/* ../"${GH_BRANCH}" -rf 2>/dev/null || :
	cd ../"${GH_BRANCH}"

	git add .
	git config user.name "Travis CI"
        git config user.email "<your@email.com>"
	git commit -m "Deploy to GitHub Pages"

	# Force push from the current repo's master branch to the remote
	# repo's gh-pages branch. (All previous history on the gh-pages branch
	# will be lost, since we are overwriting it.) We redirect any output to
	# /dev/null to hide any sensitive credential data that might otherwise be exposed.
	# tokens GH_TOKEN and GH_REF will be provided as Travis CI environment variables
	git push --force --quiet "https://${GH_TOKEN}@${GH_REF}"
fi
