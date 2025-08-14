#!/bin/bash

#* CONFIGURATION *#

GIT_DIR="$HOME/tmp/andamira.github.io/"

# push updated docs
cd $GIT_DIR
git add . && \
git commit -m "update docs" && \
git push

