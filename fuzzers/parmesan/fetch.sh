#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

git clone --no-checkout https://github.com/google/AFL.git "$FUZZER/afl"
git -C "$FUZZER/afl" checkout 61037103ae3722c8060ff7082994836a794f978e
cp "$FUZZER/src/afl_driver.cpp" "$FUZZER/afl/afl_driver.cpp"

git clone --no-checkout https://github.com/vusec/parmesan "$FUZZER/repo"
git -C "$FUZZER/repo" checkout fac580130146c07a2a0f82a24dfe0704e1851ab3

# Use Angora version of gen_library_abilist.sh script (because it handles
# numbered .so extensions properly)
wget -O "$FUZZER/repo/tools/gen_library_abilist.sh" \
    https://raw.githubusercontent.com/AngoraFuzzer/Angora/master/tools/gen_library_abilist.sh

cp "$FUZZER/src/angora_driver.c" "$FUZZER/repo/angora_driver.c"
