#!/bin/bash

set -e

# Configuration
ARCHITECTURE="arm64"
DISTRIBUTION="bookworm"
MIRROR="http://deb.debian.org/debian/"

lb clean

lb config \
    --architecture "$ARCHITECTURE" \
    --distribution="$DISTRIBUTION" \
    --mirror-bootstrap "$MIRROR" \
    --mirror-binary "$MIRROR" \
    --archive-areas "main contrib non-free non-free-firmware"
