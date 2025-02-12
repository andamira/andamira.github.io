#!/bin/bash
#
# Prunes the repository that gets the


#* CONFIGURATION *#

REPO_DIR="$HOME/dev/rust/libera/andamira.github.io/libera"

cd "$REPO_DIR"

git checkout main
git checkout --orphan new-main
git commit -m "prune history"

git branch -D main    # Deletes the old reference
git branch -m main    # Renames new-main to main

git push --force origin main
