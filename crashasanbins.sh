#!/bin/bash
set -e

cd tools/captain
#fuzzers=("afl" "aflplusplus" "aflfast" "parmesan" "symcc_afl" "radamsa")
fuzzers=("llvm_crashes_asan")
#fuzzers=("aflplusplus")
#bms=("binutils" "libpng"  "libxml2" "openssl" "lua" "libtiff" "cflow" "jq" "exiv2" "mp42aac" "wav2swf")
bms=("libpng"  "libxml2" "openssl" "lua"  "cflow" "jq" "mp42aac")
#fuzzers=("afl" "aflplusplus" "libpng"  "libxml2" "openssl" "lua" "aflfast")
#parmesan php sqlite3 error
#bms=("libtiff")
# Build the docker image for AFL and a Magma target (e.g., libpng)
rm -rf crashbinsmulitisanitizer
mkdir crashbinsmulitisanitizer
cd crashbinsmulitisanitizer
#-ldl -lz -lpthread -lexpat -lpcap -lm -lncurses 
for fuzzer in ${fuzzers[@]}
do
	for bm in ${bms[@]}
	do
		mkdir -p $fuzzer/$bm
		echo $fuzzer &&  echo $bm && docker run --name="${fuzzer}---${bm}" --network host -d magma/$fuzzer/$bm && docker cp "${fuzzer}---${bm}":magma_out $fuzzer/$bm/  &&  docker stop "${fuzzer}---${bm}" && docker rm -f "${fuzzer}---${bm}"
	done
done
