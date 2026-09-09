#!/bin/bash
#
# Prunes the repository that gets the


#* CONFIGURATION *#

source .env
# LIB_DIR=""
# GIT_DIR=""

cd "$GIT_DIR"

git checkout main
git checkout --orphan new-main
git commit -m "prune history"

git branch -D main    # Deletes the old reference
git branch -m main    # Renames new-main to main

git push --force origin main
