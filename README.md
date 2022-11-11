# fceval_magma
extension project from Magma for building fuzzer-benchmark pairs

**Pre-compiled bins for the fuzzers: afl, aflplusplus, fairfuzz, moptafl_asan, symcc_afl**: [linked to google drive](https://drive.google.com/file/d/155kaNliBDyH4ARykX9if0gIDpepbYJox/view?usp=sharing). Also,you could build them by the fuzzers and targets in corresponding folders.

**Pre-compiled Bins for different numbers of crashes because of compilation configurations in the motivation section**: [linked to google drive](https://drive.google.com/file/d/1CmZ2AcbmhgkXqi46f5pFzEbX9FHTjKoX/view?usp=sharing). Also,you could build them by the fuzzer llvm_crashes_asan with different settings,such as optimization levels. 

**Pre-compiled Bins for testing the bug finding capacities by four sanitizers**: [linked to google drive](https://drive.google.com/file/d/1DSEUm8uIwvi6hTQx7yHPyAW2Sb4Fkr4U/view?usp=sharing). Also,you could build them by the fuzzer llvm_crashes_asan with four sanitizers in instrument.sh.

Usally, we only need to make binaries by the command: cd tools/captain && FUZZER=${fuzzer} TARGET=${bm} CANARY_MODE=2 ./build.sh. Please refer to the build****.sh files in the root folder.

For more details, please refer to https://hexhive.epfl.ch/magma/docs/getting-started.html
