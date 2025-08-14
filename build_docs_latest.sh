#!/bin/bash
#
# Builds the docs of the published version and deploys them to the github page
# https:://andamira.github.io/devela/latest/devela/
#
# repo: https://github.com/andamira/andamira.github.io
#
# NOTE: before building should run in devela: `git stash -u`
# and afterwards: `git pop`.

#* CONFIGURATION *#

VERSION="0.24.0" # LATEST PUBLISHED VERSION

WORK_DIR="$HOME/dev/rust/libera/devela"
GIT_DIR="$HOME/tmp/andamira.github.io/"
DEV_DIR="$GIT_DIR/devela/"
TMP_DIR="$GIT_DIR/devela/tmp"
OUT_DIR="$DEV_DIR/$VERSION"
OUT_SYM="$DEV_DIR/latest"

CMD="CARGO_TARGET_DIR=\"$TMP_DIR\" RUSTFLAGS=\"--cfg nightly -Ctarget-cpu=native\" RUSTDOCFLAGS=\"--generate-link-to-definition --html-in-header ./config/rustdoc-header.html --cfg nightly -Z unstable-options\" cargo +nightly doc -F _docsrs --no-deps"


# compile docs
echo "Building the latest published version of devela docs. . ."
cd "$WORK_DIR"
echo $CMD
eval $CMD

# delete previous build
rm -r "$OUT_DIR"
# create `latest` symlink
ln -sf "$VERSION" "$OUT_SYM"

# move the docs to its place & delete tmp dir
mv "$TMP_DIR/doc" "$OUT_DIR"
rm -r "$TMP_DIR"


# push updated docs
cd $GIT_DIR
git add . && \
git commit -m "update latest published docs" && \
git push


