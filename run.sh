#!/bin/bash

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env OUT: path to directory where artifacts are stored
# - env SHARED: path to directory shared with host (to store results)
# - env PROGRAM: name of program to run (should be found in $OUT)
# - env ARGS: extra arguments to pass to the program
# - env FUZZARGS: extra arguments to pass to the fuzzer
##

 
cd /targets
rm -rf out
rm -rf in
mkdir in
echo AAAAAA > in/aa
mkdir out
export AFL_SKIP_CPUFREQ=1
export AFL_NO_AFFINITY=1
export AFL_NO_UI=1
/magma/fuzzers/parmesan/repo/bin/fuzzer  --sync_afl -A  -c ./magma/lua/llvm-bc/lua-targets.json -M 100 -i in -o out  -t ./magma/lua/angora-track/lua  -- ./magma/lua/angora-fast/lua @@   2>&1 &
afl-fuzz  -m none -t 1000+ -i in  -o out  -S parmesan ./magma/lua/afl/lua @@2147483647  2>&1 &


