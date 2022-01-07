#!/bin/sh

LIB="mandelbrot"
TARGET_ARM="aarch64-apple-darwin"
TARGET_X86="x86_64-apple-darwin"

set -x

cargo build --release --target=${TARGET_ARM}
cargo build --release --target=${TARGET_X86}

lipo -create -output ${LIB}.bundle \
  target/${TARGET_ARM}/release/lib${LIB}.dylib \
  target/${TARGET_X86}/release/lib${LIB}.dylib

cp ${LIB}.bundle ../Assets
