#!/bin/bash
set -ex

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

if [ ! -d "$FUZZER/afl" ] || [ ! -d "$FUZZER/repo" ]; then
#if [ ! -d "$FUZZER/repo" ]; then
    echo "fetch.sh must be executed first."
    exit 1
fi


# build AFL
(
    cd "$FUZZER/afl"
    CC=clang make -j $(nproc) && make install
    CC=clang make -j $(nproc) -C llvm_mode && make install
)


cd "$FUZZER/repo"

export GOPATH="/opt/go"
export PATH="$GOPATH/bin:/opt/cmake/bin:$PATH"

# Install Rust
export RUSTUP_HOME="$HOME/.cargo/"
export CARGO_HOME="$HOME/.cargo/"
export PATH="$CARGO_HOME/bin:$PATH"
./build/install_rust.sh

# Install LLVM
mkdir -p "$FUZZER/repo/llvm_install"
LINUX_VER="ubuntu-18.04" LLVM_VER="7.0.1" PREFIX="$FUZZER/repo/llvm_install" ./build/install_llvm.sh

# Build Angora
export PATH="$FUZZER/repo/llvm_install/clang+llvm/bin:$PATH"
export LD_LIBRARY_PATH="$FUZZER/repo/llvm_install/clang+llvm/lib:$LD_LIBRARY_PATH"
./build/build.sh

# Compile angora_driver.c
mkdir -p "$OUT/llvm-bc"
gclang $CFLAGS -c "angora_driver.c" -fPIC -o "$OUT/llvm-bc/angora_driver.o"

mkdir -p "$OUT/angora-fast"
USE_FAST=1 "./bin/angora-clang" $CFLAGS -c "angora_driver.c" -fPIC -o "$OUT/angora-fast/angora_driver.o"

mkdir -p "$OUT/angora-track"
USE_TRACK=1 "./bin/angora-clang" $CFLAGS -c "angora_driver.c" -fPIC -o "$OUT/angora-track/angora_driver.o"


export PATH=$PATH:$FUZZER/repo:$FUZZER/afl

