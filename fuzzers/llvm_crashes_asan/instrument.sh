#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env MAGMA: path to Magma support files
# - env OUT: path to directory where artifacts are stored
# - env CFLAGS and CXXFLAGS must be set to link against Magma instrumentation
##

export CC="clang"
export CXX="clang++"
export LIBS="$LIBS -l:StandaloneFuzzTargetMain.o -lstdc++"

# Build asan address sanitizers
(
    export OUT="$OUT/asan"
    export CFLAGS="$CFLAGS -fsanitize=address -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0  -Wno-error"
    export CXXFLAGS="$CXXFLAGS -fsanitize=address -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -fsanitize=address -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -L$OUT"
    echo $CFLAGS
    echo "asanCXXFLAGS $CXXFLAGS"
    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)


# Build  tsan thread sanitizers
(
    export OUT="$OUT/tsan"
    export CFLAGS="$CFLAGS -fsanitize=thread  -DFORTIFY_SOURCE=2 -fstack-protector-all -O0  -Wno-error"
    export CXXFLAGS="$CXXFLAGS -fsanitize=thread  -DFORTIFY_SOURCE=2 -fstack-protector-all -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -fsanitize=thread  -DFORTIFY_SOURCE=2 -fstack-protector-all -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -L$OUT"
    echo $CFLAGS
    echo "tsanCXXFLAGS $CXXFLAGS"

    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

# Build  ubsan undefined behavior sanitizers
(
    export OUT="$OUT/ubsan"
    export CFLAGS="$CFLAGS -fsanitize=undefined -fno-sanitize-recover=all -DFORTIFY_SOURCE=2 -fstack-protector-all    -O0  -Wno-error"
    export CXXFLAGS="$CXXFLAGS -fsanitize=undefined -fno-sanitize-recover=all -DFORTIFY_SOURCE=2 -fstack-protector-all   -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS  -fsanitize=undefined -fno-sanitize-recover=all -DFORTIFY_SOURCE=2 -fstack-protector-all  -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -L$OUT"
    echo $CFLAGS
    echo "ubsanCXXFLAGS $CXXFLAGS"
    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)
# Build  msan memory sanitizers
(
    export OUT="$OUT/msan"
    export CFLAGS="$CFLAGS -fsanitize=memory -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0  -Wno-error"
    export CXXFLAGS="$CXXFLAGS -fsanitize=memory -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -fsanitize=memory -DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer  -O0 -Wno-error"
    export LDFLAGS="$LDFLAGS -L$OUT"
    echo $CFLAGS
    echo "msanCXXFLAGS $CXXFLAGS"
    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)

# NOTE: We pass $OUT directly to the target build.sh script, since the artifact
#       itself is the fuzz target. In the case of Angora, we might need to
#       replace $OUT by $OUT/fast and $OUT/track, for instance.
