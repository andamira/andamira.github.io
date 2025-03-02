#!/bin/bash
#
# Compiles docs and deploys to github page
# https:://andamira.github.io/devela/doc/devela/
#
# repo: https://github.com/andamira/andamira.github.io
#
# NOTE: before building should run in devela: `git stash -u`
# and afterwards: `git pop`.

#* CONFIGURATION *#

WORK_DIR="$HOME/dev/rust/libera/devela"
GIT_DIR="$HOME/tmp/andamira.github.io/"
OUT_DIR="$HOME/tmp/andamira.github.io/libera"

# CMD="CARGO_TARGET_DIR=$OUT_DIR cargo +nightly nd -F _docsrs"
# NOTE: need to have in path: ../utils/cargo-nightly
CMD="CARGO_TARGET_DIR=$OUT_DIR cargo +nightly native nd -F _docsrs"

# delete previous version
rm -r "$OUT_DIR"

# compile docs
echo "Compiling latest devela docs. . ."
cd "$WORK_DIR"
echo $CMD
eval $CMD

# delete debug info
rm -r "$OUT_DIR/debug"

# push updated docs
cd $GIT_DIR
git add . && \
git commit -m "update docs" && \
git push


