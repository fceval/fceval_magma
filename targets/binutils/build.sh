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
./configure  --with-pic --prefix="$OUT/"
make -j$(nproc) clean
#make -j$(nproc)  CFLAGS="-fpie -pie" 
make -j$(nproc)
make install
make distclean
