#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"

cmake -S "$PROJECT_ROOT" -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS_RELEASE="-O3 -march=native" \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DFFT_TN_BUILD_TESTS=OFF

cmake --build "$BUILD_DIR" -j 1

grep '^CMAKE_CXX_COMPILER' "$BUILD_DIR/CMakeCache.txt"
