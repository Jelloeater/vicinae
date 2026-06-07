#!/usr/bin/env bash
#
# Builds debian packages, assumes binaries have already been built.

set -euo pipefail

VERSION="${VERSION:-""}"
if [[ -z "$VERSION" ]]; then
  echo "Error: Missing env var VERSION" >&2
  exit 1
fi

VERSION="${VERSION#v}"

BUILD_DIR="${BUILD_DIR:-"$(pwd)/build"}"
INSTALL_DIR="${INSTALL_DIR:-"$(pwd)/install"}"
if [[ ! -e "$BUILD_DIR/bin/vicinae" && ! -e "$INSTALL_DIR/bin/vicinae" ]]; then
  echo "Error: Missing expected build artifacts at \"$BUILD_DIR/bin/vicinae\" or \"$INSTALL_DIR/bin/vicinae\" (was vicinae built and installed?)" >&2
  exit 1
fi

if ! command -v nfpm &>/dev/null; then
  echo "Error: nfpm is missing, please install it:" >&2
  echo "       https://nfpm.goreleaser.com/docs/install/" >&2
  exit 1
fi

exec nfpm package -p deb
