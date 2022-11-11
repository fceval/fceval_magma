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
export LDFLAGS="$LDFLAGS -ldl -lutil"
cd "$TARGET/repo"
./configure --prefix="$OUT/" --disable-shared --disable-gdb --disable-libdecnumber --disable-readline --disable-sim --disable-ld
make -j$(nproc) clean
make -j$(nproc)
make install
make distclean
