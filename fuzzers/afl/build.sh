#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

if [ ! -d "$FUZZER/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1
fi

cd "$FUZZER/repo"
CC=clang make -j $(nproc) && make install
CC=clang make -j $(nproc) -C llvm_mode && make install
echo "export PATH=$PATH:$FUZZER/repo" >> /etc/profile
source /etc/profile
# compile afl_driver.cpp
"./afl-clang-fast++" $CXXFLAGS -std=c++11 -c "afl_driver.cpp" -fPIC -o "$OUT/afl_driver.o"
