#!/bin/bash
#
# Builds the docs of the unpublished version and deploys them to the github page
# https:://andamira.github.io/devela/unpublished/devela/
#
# repo: https://github.com/andamira/andamira.github.io
#
# NOTE: before building should run in devela: `git stash -u`
# and afterwards: `git pop`.

#* CONFIGURATION *#

WORK_DIR="$HOME/dev/rust/libera/devela"
GIT_DIR="$HOME/tmp/andamira.github.io/"
DEV_DIR="$GIT_DIR/devela/"
TMP_DIR="$GIT_DIR/devela/tmp"
OUT_DIR="$DEV_DIR/unpublished"

CMD="CARGO_TARGET_DIR=\"$TMP_DIR\" RUSTFLAGS=\"--cfg nightly -Ctarget-cpu=native\" RUSTDOCFLAGS=\"--generate-link-to-definition --html-in-header ./config/rustdoc-header.html --cfg nightly -Z unstable-options\" cargo +nightly doc -F _docsrs --no-deps"


# compile docs
echo "Building the unpublished version of devela docs. . ."
cd "$WORK_DIR"
echo $CMD
eval $CMD

# delete previous build
rm -r "$OUT_DIR"

# delete debug info
mv "$TMP_DIR/doc" "$OUT_DIR"
rm -r "$TMP_DIR"


# push updated docs
cd $GIT_DIR
git add . && \
git commit -m "update unpublished docs" && \
git push


