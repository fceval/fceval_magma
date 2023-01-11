#!/bin/bash
set -e

cd tools/captain
fuzzers=("parmesan" "symcc_afl")
bms=("binutils" "libpng" "libxml2" "openssl" "lua" "cflow" "jq")
#bms=("mp42aac")
#fuzzers=("afl" "aflplusplus" "aflfast")
#parmesan php sqlite3 error
#bms=("libtiff")
# Build the docker image for AFL and a Magma target (e.g., libpng)

 
for fuzzer in ${fuzzers[@]}
do
	for bm in ${bms[@]}
	do
		echo $fuzzer &&  echo $bm && (FUZZER=${fuzzer} TARGET=${bm} CANARY_MODE=2 ./build.sh)	
	done
done
