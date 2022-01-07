#!/bin/sh

LIB="mandelbrot"
TARGET="x86_64-pc-windows-gnu"

set -x

cargo build --release --target=${TARGET}

cp target/${TARGET}/release/${LIB}.dll ../Assets
