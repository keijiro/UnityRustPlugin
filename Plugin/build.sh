#!/bin/sh

LIB="mandelbrot"
OPT="--release"
DST="../Assets"

UNAME=`uname`

if [ $UNAME = Linux ] && `grep -i -q "microsoft" /proc/version`; then
    IS_WSL="WSL"
fi

if [ -n "$1" ] && [ $1 = ios ]; then
    IS_IOS="iOS"
    if ! `grep -i -q "staticlib" Cargo.toml`; then
        echo '** iOS build error: create-type should be staticlib'
        echo 'Please modify Cargo.toml to change crate-type to "staticlib".'
        exit 1
    fi
fi

set -x

if [ $IS_IOS ]; then

    TARGET="aarch64-apple-ios"

    cargo build ${OPT} --target=${TARGET}

    cp target/${TARGET}/release/lib${LIB}.a ${DST}

elif [ $IS_WSL ]; then

    TARGET="x86_64-pc-windows-gnu"

    cargo build ${OPT} --target=${TARGET}

    cp target/${TARGET}/release/${LIB}.dll ${DST}

elif [ $UNAME = Linux ]; then

    cargo build ${OPT}

    cp target/release/lib${LIB}.so ${DST}

elif [ $UNAME = Darwin ]; then

    TARGET_ARM="aarch64-apple-darwin"
    TARGET_X86="x86_64-apple-darwin"

    cargo build ${OPT} --target=${TARGET_ARM}
    cargo build ${OPT} --target=${TARGET_X86}

    lipo -create -output ${LIB}.bundle \
      target/${TARGET_ARM}/release/lib${LIB}.dylib \
      target/${TARGET_X86}/release/lib${LIB}.dylib

    cp ${LIB}.bundle ${DST}

fi
