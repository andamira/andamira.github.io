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
OUT_DIR="$GIT_DIR/devela/$VERSION"
OUT_DIR_LATEST="$GIT_DIR/devela/latest"

CMD="CARGO_TARGET_DIR=\"$OUT_DIR\" RUSTFLAGS=\"--cfg nightly -Ctarget-cpu=native\" RUSTDOCFLAGS=\"--generate-link-to-definition --html-in-header ./config/rustdoc-header.html --cfg nightly -Z unstable-options\" cargo +nightly doc -F _docsrs --no-deps"

# delete previous build
rm -r "$OUT_DIR"

# create symlink
ln -sf "$VERSION" "$OUT_DIR_LATEST"


# compile docs
echo "Compiling the latest published version of devela docs. . ."
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


