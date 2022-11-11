#!/bin/bash
set -e

##
# Pre-requirements:
# - env TARGET: path to target work dir
# - env OUT: path to directory where artifacts are stored
# - env CC, CXX, FLAGS, LIBS, etc...
##

if [ ! -d "$TARGET/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1
fi
export ASAN_OPTIONS=detect_leaks=0

cd "$TARGET/repo"
cmake -DJAS_ENABLE_SHARED=OFF -DALLOW_IN_SOURCE_BUILD=ON .
make -j$(nproc) clean
make -j$(nproc)
cp src/appl/imginfo "$OUT/"
make -j$(nproc) clean
