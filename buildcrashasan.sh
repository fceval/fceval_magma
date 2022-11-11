#!/bin/bash
set -e

cd tools/captain
#fuzzers=("afl" "aflplusplus" "aflfast" "parmesan" "symcc_afl" "radamsa")
fuzzers=("llvm_crashes_asan")
#fuzzers=("symcc_afl")
#bms=("binutils" "libpng"  "libxml2" "openssl" "lua" "libtiff" "cflow" "jq" "exiv2" "mp42aac" "wav2swf")
#bms=("binutils" "binutils_crash" "libpng"  "libxml2" "openssl" "lua"  "cflow" "jq" "exiv2" "mp42aac")
bms=("libpng"  "libxml2" "openssl" "lua"  "cflow" "jq" "mp42aac")
#fuzzers=("afl" "aflplusplus" "aflfast")
#parmesan php sqlite3 error
#bms=("libtiff")
# Build the docker image for AFL and a Magma target (e.g., libpng)

#-ldl -lz -lpthread -lexpat -lpcap -lm -lncurses 
for fuzzer in ${fuzzers[@]}
do
	for bm in ${bms[@]}
	do
		echo $fuzzer &&  echo $bm && (FUZZER=${fuzzer} TARGET=${bm} CANARY_MODE=2 ./build.sh)		
	done
done
