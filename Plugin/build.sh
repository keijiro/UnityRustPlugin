#!/bin/sh

LIB="mandelbrot"
OPT="--release"

UNAME=`uname`

if [ $UNAME = Linux ]; then
    IS_WSL=`grep -i -q "microsoft" /proc/version`
fi

set -x

if [ $IS_WSL ]; then

    TARGET="x86_64-pc-windows-gnu"

    cargo build ${OPT} --target=${TARGET}

    cp target/${TARGET}/release/${LIB}.dll ../Assets

elif [ $UNAME = Linux ]; then

    cargo build ${OPT}

    cp target/release/lib${LIB}.so ../Assets

elif [ $UNAME = Darwin ]; then

    TARGET_ARM="aarch64-apple-darwin"
    TARGET_X86="x86_64-apple-darwin"

    cargo build ${OPT} --target=${TARGET_ARM}
    cargo build ${OPT} --target=${TARGET_X86}

    lipo -create -output ${LIB}.bundle \
      target/${TARGET_ARM}/release/lib${LIB}.dylib \
      target/${TARGET_X86}/release/lib${LIB}.dylib

    cp ${LIB}.bundle ../Assets

fi
