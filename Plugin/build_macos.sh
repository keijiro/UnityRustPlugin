#!/bin/sh

TARGET_NAME="mandelbrot"
ARCH_ARM="aarch64-apple-darwin"
ARCH_X86="x86_64-apple-darwin"

set -x

cargo build --release --target=$ARCH_ARM
cargo build --release --target=$ARCH_X86

lipo -create -output ${TARGET_NAME}.bundle \
  target/${ARCH_ARM}/release/lib${TARGET_NAME}.dylib \
  target/${ARCH_X86}/release/lib${TARGET_NAME}.dylib

cp ${TARGET_NAME}.bundle ../Assets
