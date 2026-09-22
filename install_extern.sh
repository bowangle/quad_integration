#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FFT_DIR="$SCRIPT_DIR/extern/fft-tn-quadp"

echo "==> Cleaning extern/ ..."
rm -rf "$SCRIPT_DIR"/extern/*

echo "==> Initializing submodules..."
git -C "$SCRIPT_DIR" submodule update --init --recursive

echo "==> Installing fft-tn-quadp:"
cd "$FFT_DIR"
bash install_extern.sh

echo "==> Done!"
