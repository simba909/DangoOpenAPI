#!/usr/bin/env bash

set -euo pipefail

# Clean up any previous run
rm -rf workspace
xcodebuild clean -scheme DangoOpenAPI -project DangoOpenAPI.xcodeproj

# Create necessary directory structure and files
mkdir -p workspace/tmp
touch workspace/tmp/resultBundleStream.json

# Build for testing
xcodebuild build-for-testing \
    -scheme DangoOpenAPI \
    -project DangoOpenAPI.xcodeproj \
    -destination "platform=iOS Simulator,name=iPhone 15" \
    -testProductsPath workspace/TestProducts.xctestproducts \
    -derivedDataPath workspace/DerivedData \
    -resultBundleVersion 3 \
    -resultBundlePath workspace/resultbundle.xcresult \
    -resultStreamPath workspace/tmp/resultBundleStream.json  \
    -IDEPostProgressNotifications=YES \
    COMPILER_INDEX_STORE_ENABLE=NO \
    -hideShellScriptEnvironment
