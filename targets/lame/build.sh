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
#export LIBS="$LIBS -ldl -lz -lpthread -lexpat -lpcap -lm -lncurses"
cd "$TARGET/repo"
./configure --disable-shared
make -j$(nproc) clean
#make -j$(nproc)
#cp frontend/lame "$OUT/"
#make -j$(nproc) clean
