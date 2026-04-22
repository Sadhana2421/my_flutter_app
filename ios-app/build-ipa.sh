#!/bin/bash

set -euo pipefail

PROJECT="VishwagraIOS.xcodeproj"
SCHEME="VishwagraIOS"
CONFIGURATION="Release"
ARCHIVE_PATH="$(pwd)/build/VishwagraIOS.xcarchive"
EXPORT_PATH="$(pwd)/build/export"
EXPORT_OPTIONS_PLIST="$(pwd)/ExportOptions.plist"

echo "Cleaning old build output..."
rm -rf "$(pwd)/build"
mkdir -p "$EXPORT_PATH"

echo "Archiving app..."
xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -destination "generic/platform=iOS" \
  -archivePath "$ARCHIVE_PATH" \
  archive

echo "Exporting IPA..."
xcodebuild \
  -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$EXPORT_PATH" \
  -exportOptionsPlist "$EXPORT_OPTIONS_PLIST"

echo "Done. Check: $EXPORT_PATH"
