#!/bin/bash

#* CONFIGURATION *#

source .env
# LIB_DIR=""
# GIT_DIR=""

# push updated docs
cd $GIT_DIR
git add . && \
git commit -m "update docs" && \
git push

