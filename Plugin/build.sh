#!/bin/sh

LIB="mandelbrot"
OPT="--release"
DST="../Assets"

UNAME=`uname`

[ $UNAME = Linux ] && `grep -i -q "microsoft" /proc/version` && IS_WSL="WSL"

[ -n "$1" ] && [ $1 = android ] && IS_ANDROID="Android"

if [ -n "$1" ] && [ $1 = ios ]; then
    IS_IOS="iOS"
    if ! `grep -i -q "staticlib" Cargo.toml`; then
        echo '** iOS build error: create-type should be staticlib.'
        echo 'Please modify Cargo.toml to change crate-type to "staticlib".'
        exit 1
    fi
fi

if [ $IS_IOS ]; then

    TARGET="aarch64-apple-ios"

    set -x
    cargo build $OPT --target=$TARGET
    cp target/${TARGET}/release/lib${LIB}.a ${DST}/iOS

elif [ $IS_ANDROID ]; then

    TARGET="aarch64-linux-android"

    if [ -z "$ANDROID_NDK" ]; then
        echo '** Android build error: $ANDROID_NDK is not defined.'
        exit 1
    fi

    export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang"

    set -x
    cargo build $OPT --target=$TARGET
    cp target/${TARGET}/release/lib${LIB}.so ${DST}/Android

elif [ $IS_WSL ]; then

    TARGET="x86_64-pc-windows-gnu"

    set -x
    cargo build $OPT --target=$TARGET
    cp target/${TARGET}/release/${LIB}.dll ${DST}/Windows

elif [ $UNAME = Linux ]; then

    set -x
    cargo build $OPT
    cp target/release/lib${LIB}.so ${DST}/Linux

elif [ $UNAME = Darwin ]; then

    TARGET_ARM="aarch64-apple-darwin"
    TARGET_X86="x86_64-apple-darwin"

    set -x

    cargo build $OPT --target=$TARGET_ARM
    cargo build $OPT --target=$TARGET_X86

    lipo -create -output ${LIB}.bundle \
      target/${TARGET_ARM}/release/lib${LIB}.dylib \
      target/${TARGET_X86}/release/lib${LIB}.dylib

    cp ${LIB}.bundle ${DST}/macOS

fi
