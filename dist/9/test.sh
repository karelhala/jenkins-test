#!/bin/bash

TRAVIS_PULL_REQUEST=5

rm -rf $TRAVIS_PULL_REQUEST
                mkdir $TRAVIS_PULL_REQUEST
                cp ./* $TRAVIS_PULL_REQUEST -R 2>/dev/null
                rm -rf $TRAVIS_PULL_REQUEST/$TRAVIS_PULL_REQUEST
                git add $TRAVIS_PULL_REQUEST

